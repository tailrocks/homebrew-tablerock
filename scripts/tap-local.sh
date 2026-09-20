#!/usr/bin/env bash
# Prepare the runner tap environment before `brew audit --strict --online`.
# 1. Link this checkout as tailrocks/homebrew-tablerock and trust it.
# 2. Untap every foreign tap: bare `brew audit` loads all tapped formulae,
#    so a broken preinstalled tap (observed: hashicorp/tap vagrant.rb with
#    no URL) or API quota burned on foreign formulae fails our audit.
#    Our formulae/casks have no cross-tap dependencies, so foreign taps
#    are never needed here. Runners are ephemeral; nothing persists.
# 3. Authenticate brew API calls from the step GH_TOKEN (fallback: `gh auth
#    token`), raising the 60/hr unauthenticated quota that --online cask
#    audits exhaust on shared runner IPs.
set -euo pipefail

# Canonical brew name strips the homebrew- repo prefix: repo
# tailrocks/homebrew-tablerock, tap dir .../Taps/tailrocks/homebrew-tablerock,
# listed by `brew tap` as tailrocks/tablerock.
OUR_TAP="tailrocks/tablerock"
OUR_TAP_DIR="homebrew-tablerock"

tap_dir="$(brew --repo)/Library/Taps/tailrocks"
mkdir -p "$tap_dir"
# Replace any pre-existing (e.g. upstream) checkout of this tap slot: ln -sfn
# over a real directory would nest the link inside it instead of replacing it.
rm -rf "${tap_dir:?}/$OUR_TAP_DIR"
ln -s "$PWD" "$tap_dir/$OUR_TAP_DIR"

foreign="$(brew tap | grep -v -x "$OUR_TAP" || true)"
if [ -n "$foreign" ]; then
  while IFS= read -r tap; do
    [ -n "$tap" ] || continue
    brew untap --force "$tap" || true
  done <<< "$foreign"
fi
brew trust "$OUR_TAP"

# The generated workflow exposes GH_TOKEN (and MISE_GITHUB_TOKEN) to CI steps;
# `gh auth token` is a fallback for environments where it does not.
if [ -n "${GITHUB_ENV:-}" ]; then
  token="${GH_TOKEN:-${MISE_GITHUB_TOKEN:-}}"
  if [ -z "$token" ] && command -v gh >/dev/null 2>&1; then
    token="$(gh auth token 2>/dev/null || true)"
  fi
  if [ -n "$token" ]; then
    echo "::add-mask::$token"
    echo "HOMEBREW_GITHUB_API_TOKEN=$token" >> "$GITHUB_ENV"
  fi
fi

if brew tap | grep -q -x "$OUR_TAP"; then
  echo "tap-local: $OUR_TAP ready"
else
  echo "tap-local: $OUR_TAP missing after setup" >&2
  exit 1
fi
