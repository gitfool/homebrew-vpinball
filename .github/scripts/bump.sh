#!/usr/bin/env bash

set -euo pipefail

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

echo -e "Configuring git user"
git config set color.ui always
git config set user.name "github-actions[bot]"
git config set user.email "github-actions[bot]@users.noreply.github.com"

TAP="${GITHUB_REPOSITORY/homebrew-/}"
echo -e "Tapping ${TAP}"
brew tap ${TAP}

# Bump a nightly cask that uses GitHub Actions artifacts as its download source.
# Usage: bump_nightly <cask-name> <new-version> <repo> <artifact-template>
#
# The artifact template uses placeholders: {version}, {arch}, {os}, {ext}
# e.g. "VPinballX_BGFX-{version}-{os}-{arch}-Release.{ext}"
#
# The {arch}, {os}, and {ext} values are read from the cask's own stanzas,
# so they match exactly what the cask interpolates into its URL.
bump_nightly() {
    local name="$1"
    local latest="$2"
    local repo="$3"
    local template="$4"
    local path
    path="$(brew edit --cask "$name" --print-path)"

    # Parse arch values from the cask: arch arm: "...", intel: "..."
    local arch_arm arch_intel
    arch_arm=$(gsed -n 's/.*arch.*arm: "\([^"]*\)".*/\1/p' "$path")
    arch_intel=$(gsed -n 's/.*arch.*intel: "\([^"]*\)".*/\1/p' "$path")

    # Parse os values from the cask: os macos: "...", linux: "..."
    local os_macos os_linux
    os_macos=$(gsed -n 's/.*\bos\b.*macos: "\([^"]*\)".*/\1/p' "$path")
    os_linux=$(gsed -n 's/.*\bos\b.*linux: "\([^"]*\)".*/\1/p' "$path")

    # Parse ext values from the cask: on_system_conditional macos: "...", linux: "..."
    local ext_macos ext_linux
    ext_macos=$(gsed -n 's/.*on_system_conditional.*macos: "\([^"]*\)".*/\1/p' "$path")
    ext_linux=$(gsed -n 's/.*on_system_conditional.*linux: "\([^"]*\)".*/\1/p' "$path")

    # Derive architecture keys from sha256 hash entries in the cask
    local -a keys=()
    while IFS= read -r key; do
        keys+=("$key")
    done < <(gsed -n '/^  sha256/,/^$/{ s/.*\b\(arm\|intel\|arm64_linux\|x86_64_linux\):.*/\1/p }' "$path")

    declare -A shas=()
    declare -A ids=()

    local key os arch ext artifact_name artifact_id tmpfile sha
    for key in "${keys[@]}"; do
        case "$key" in
            arm)          os="${os_macos:-}"; arch="$arch_arm";   ext="${ext_macos:-dmg}" ;;
            intel)        os="${os_macos:-}"; arch="$arch_intel"; ext="${ext_macos:-dmg}" ;;
            arm64_linux)  os="${os_linux:-}"; arch="$arch_arm";   ext="${ext_linux:-tar.gz}" ;;
            x86_64_linux) os="${os_linux:-}"; arch="$arch_intel"; ext="${ext_linux:-tar.gz}" ;;
            *) echo -e "${RED}  Unknown sha256 key: ${key}${RESET}"; return 1 ;;
        esac

        artifact_name="${template}"
        artifact_name="${artifact_name//\{version\}/$latest}"
        artifact_name="${artifact_name//\{os\}/$os}"
        artifact_name="${artifact_name//\{arch\}/$arch}"
        artifact_name="${artifact_name//\{ext\}/$ext}"

        echo -e "  Fetching artifact: ${artifact_name}"
        artifact_id=$(gh api "repos/${repo}/actions/artifacts?name=${artifact_name}&per_page=1" \
            --jq '.artifacts[0].id // empty')

        if [ -z "$artifact_id" ]; then
            echo -e "${RED}  Artifact not found: ${artifact_name}${RESET}"
            return 1
        fi

        echo -e "  Downloading ${artifact_name} (artifact ${artifact_id})..."
        tmpfile=$(mktemp)
        if ! gh api "repos/${repo}/actions/artifacts/${artifact_id}/zip" > "$tmpfile"; then
            echo -e "${RED}  Download failed: ${artifact_name}${RESET}"
            rm -f "$tmpfile"
            return 1
        fi

        sha=$(shasum -a 256 "$tmpfile" | cut -d' ' -f1)
        echo -e "  ${key}: id=${artifact_id} sha=${sha}"
        rm -f "$tmpfile"

        shas[$key]="$sha"
        ids[$key]="$artifact_id"
    done

    # Update version
    gsed -i "s/version \".*\"/version \"${latest}\"/" "$path"

    # Update sha256 values
    for key in "${keys[@]}"; do
        gsed -i "/^  sha256/,/^$/ s/${key}:\(\s*\)\"[^\"]*\"/${key}:\1\"${shas[$key]}\"/" "$path"
    done

    # Update artifact IDs (on_arch_conditional for macos, plain string for linux)
    local macos_ids="" linux_id=""
    for key in "${keys[@]}"; do
        case "$key" in
            arm)          macos_ids="${macos_ids:+$macos_ids, }arm: \"${ids[$key]}\"" ;;
            intel)        macos_ids="${macos_ids:+$macos_ids, }intel: \"${ids[$key]}\"" ;;
            x86_64_linux) linux_id="${ids[$key]}" ;;
            arm64_linux)  ;; # not used for artifact_id currently
        esac
    done
    if [ -n "$macos_ids" ]; then
        gsed -i "s/on_arch_conditional([^)]*)/on_arch_conditional(${macos_ids})/" "$path"
    fi
    if [ -n "$linux_id" ]; then
        gsed -i "/artifact_id/,/linux:/s/linux: \"[^\"]*\"/linux: \"${linux_id}\"/" "$path"
    fi

    if git diff --quiet -- "$path"; then
        echo -e "${YELLOW}${name}: nothing changed${RESET}"
    else
        git add "$path"
        git commit -m "Bump ${name} to ${latest}"
    fi
}

echo -e "Running livecheck ${TAP}..."
items="$(brew livecheck --tap ${TAP} --json || echo "[]")"
jq --color-output <<<"$items"

echo -e "Processing livecheck versions..."
jq --compact-output '.[]' <<<"$items" | while IFS= read -r item; do
    name=$(jq -r '.cask // .formula' <<<"$item")
    kind=$(jq -r 'if .cask then "cask" else "formula" end' <<<"$item")
    status=$(jq -r '.status' <<<"$item")
    current=$(jq -r '.version.current' <<<"$item")
    latest=$(jq -r '.version.latest' <<<"$item")
    outdated=$(jq -r '.version.outdated' <<<"$item")
    newer=$(jq -r '.version.newer_than_upstream' <<<"$item")

    if [ "$status" == "error" ] || [ "$status" == "skipped" ]; then
        echo -e "${RED}${name}: $(jq -r '.messages[0] // .status' <<<"$item")${RESET}"
        continue
    elif [ "$latest" == "null" ]; then
        echo -e "${RED}${name}: latest is null${RESET}"
        continue
    elif [ "$newer" == "true" ]; then
        echo -e "${YELLOW}${name}: newer than upstream${RESET}"
        continue
    elif [ "$outdated" != "true" ]; then
        echo -e "${GREEN}${name}: up-to-date${RESET}"
        continue
    fi

    echo -e "${BLUE}Bumping ${name} from ${current} to ${latest}...${RESET}"

    # Special handling for nightly casks: download artifacts via GitHub API
    if [ "$name" == "vpinball-nightly" ]; then
        if ! bump_nightly "$name" "$latest" "vpinball/vpinball" "VPinballX_BGFX-{version}-{os}-{arch}-Release.{ext}"; then
            echo -e "${RED}${name}: bump_nightly failed${RESET}"
        fi
        continue
    fi

    if [ "$kind" == "cask" ]; then
        if ! brew bump-cask-pr --write-only --no-audit --no-style "$name" --version "$latest" --verbose; then
            echo -e "${RED}${name}: bump-cask-pr failed${RESET}"
            continue
        fi
        path="$(brew edit --cask "$name" --print-path)"
    else
        if ! brew bump-formula-pr --write-only --no-audit --no-style "$name" --version "$latest" --verbose; then
            echo -e "${RED}${name}: bump-formula-pr failed${RESET}"
            continue
        fi
        path="$(brew edit "$name" --print-path)"
    fi

    if git diff --quiet -- "$path"; then
        echo -e "${YELLOW}${name}: nothing changed${RESET}"
    else
        git add "$path"
        git commit -m "Bump ${name} to ${latest}"
    fi
done

echo -e "${BLUE}Diffing changes...${RESET}"
git diff origin/${GITHUB_REF_NAME}..HEAD

if git diff --quiet origin/${GITHUB_REF_NAME}..HEAD; then
    echo -e "${YELLOW}Nothing changed${RESET}"
else
    echo -e "${BLUE}Pushing changes to origin/${GITHUB_REF_NAME}...${RESET}"
    git push origin "${GITHUB_REF_NAME}"
fi
