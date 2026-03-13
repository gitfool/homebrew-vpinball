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
    if [ "$kind" == "cask" ]; then
        if ! brew bump-cask-pr --write-only --no-audit "$name" --version "$latest" --verbose; then
            echo -e "${RED}${name}: bump-cask-pr failed${RESET}"
            continue
        fi
        path="$(brew edit --cask "$name" --print-path)"
    else
        if ! brew bump-formula-pr --write-only --no-audit "$name" --version "$latest" --verbose; then
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
