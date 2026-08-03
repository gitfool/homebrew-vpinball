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

# Bump vpinball-nightly by downloading artifacts directly from GitHub API
bump_nightly() {
    local name="$1"
    local latest="$2"
    local path
    path="$(brew edit --cask "$name" --print-path)"

    local sha_arm="" sha_intel="" sha_x86_64_linux=""
    local id_arm="" id_intel="" id_x86_64_linux=""

    local key os arch ext artifact_name artifact_id tmpfile sha
    for key in arm intel x86_64_linux; do
        case "$key" in
            arm)          os="macos"; arch="arm64"; ext="dmg" ;;
            intel)        os="macos"; arch="x64";   ext="dmg" ;;
            x86_64_linux) os="linux"; arch="x64";   ext="tar.gz" ;;
        esac
        artifact_name="VPinballX_BGFX-${latest}-${os}-${arch}-Release.${ext}"

        echo -e "  Fetching artifact: ${artifact_name}"
        artifact_id=$(gh api "repos/vpinball/vpinball/actions/artifacts?name=${artifact_name}&per_page=1" \
            --jq '.artifacts[0].id // empty')

        if [ -z "$artifact_id" ]; then
            echo -e "${RED}  Artifact not found: ${artifact_name}${RESET}"
            return 1
        fi

        echo -e "  Downloading ${artifact_name} (artifact ${artifact_id})..."
        tmpfile=$(mktemp)
        if ! gh api "repos/vpinball/vpinball/actions/artifacts/${artifact_id}/zip" > "$tmpfile"; then
            echo -e "${RED}  Download failed: ${artifact_name}${RESET}"
            rm -f "$tmpfile"
            return 1
        fi

        sha=$(shasum -a 256 "$tmpfile" | cut -d' ' -f1)
        echo -e "  ${key}: id=${artifact_id} sha=${sha}"
        rm -f "$tmpfile"

        case "$key" in
            arm)          sha_arm="$sha";          id_arm="$artifact_id" ;;
            intel)        sha_intel="$sha";        id_intel="$artifact_id" ;;
            x86_64_linux) sha_x86_64_linux="$sha"; id_x86_64_linux="$artifact_id" ;;
        esac
    done

    # Update version, artifact IDs, and sha256 in the cask file
    gsed -i "s/version \".*\"/version \"${latest}\"/" "$path"
    gsed -i "s/arm:          \"[^\"]*\"/arm:          \"${sha_arm}\"/" "$path"
    gsed -i "s/intel:        \"[^\"]*\"/intel:        \"${sha_intel}\"/" "$path"
    gsed -i "s/x86_64_linux: \"[^\"]*\"/x86_64_linux: \"${sha_x86_64_linux}\"/" "$path"
    gsed -i "s/on_arch_conditional(arm: \"[^\"]*\", intel: \"[^\"]*\")/on_arch_conditional(arm: \"${id_arm}\", intel: \"${id_intel}\")/" "$path"
    gsed -i "/artifact_id/,/linux:/s/linux: \"[^\"]*\"/linux: \"${id_x86_64_linux}\"/" "$path"

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

    # Special handling for vpinball-nightly: download artifacts via GitHub API
    if [ "$name" == "vpinball-nightly" ]; then
        if ! bump_nightly "$name" "$latest"; then
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
