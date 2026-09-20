#!/usr/bin/env bash
# Prepare the runner tap environment before `brew audit --strict --online`.
# 1. Link this checkout as tailrocks/homebrew-tablerock and trust it.
# 2. Untap every foreign tap: bare `brew audit` loads all tapped formulae,
#    so a broken preinstalled tap (observed: hashicorp/tap vagrant.rb with
#    no URL) or API quota burned on foreign formulae fails our audit.
#    Our formulae/casks have no cross-tap dependencies, so foreign taps
#    are never needed here. Runners are ephemeral; nothing persists.
# 3. Best-effort: authenticate brew API calls from `gh auth token` when the
#    runner has one, raising the 60/hr unauthenticated quota.
set -euo pipefail

OUR_TAP="tailrocks/homebrew-tablerock"

tap_dir="$(brew --repo)/Library/Taps/tailrocks"
mkdir -p "$tap_dir"
ln -sfn "$PWD" "$tap_dir/homebrew-tablerock"

foreign="$(brew tap | grep -v -x "$OUR_TAP" || true)"
if [ -n "$foreign" ]; then
  while IFS= read -r tap; do
    [ -n "$tap" ] || continue
    brew untap --force "$tap" || true
  done <<< "$foreign"
fi
brew trust tailrocks/tablerock

if [ -n "${GITHUB_ENV:-}" ] && command -v gh >/dev/null 2>&1; then
  if token="$(gh auth token 2>/dev/null)" && [ -n "$token" ]; then
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
