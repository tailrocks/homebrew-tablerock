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
# 4. Linux CI only: cask `--online` audit shells out to Apple's `plutil`
#    (absent on Linux; exit 127 fails the whole audit). Install the minimal
#    compatible scripts/plutil-shim.sh so the audit still validates
#    artifact plists. No-op on macOS, outside CI, or when real plutil
#    exists. DEFERRED ROOT CAUSE: remove with the shim when the generator
#    renders multi-platform unit legs and the apple leg returns.
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

# Untap foreign taps only on CI runners (ephemeral): a local
# `mise run brew:tap-local` must not destroy the developer's taps.
if [ "${GITHUB_ACTIONS:-}" = "true" ]; then
  foreign="$(brew tap | grep -v -x "$OUR_TAP" || true)"
  if [ -n "$foreign" ]; then
    while IFS= read -r tap; do
      [ -n "$tap" ] || continue
      brew untap --force "$tap" || true
    done <<< "$foreign"
  fi
fi
brew trust "$OUR_TAP"

# mise-action exports MISE_GITHUB_TOKEN to CI unit steps (verified live);
# GH_TOKEN / `gh auth token` are fallbacks for other environments.
if [ -n "${GITHUB_ENV:-}" ]; then
  token="${MISE_GITHUB_TOKEN:-${GH_TOKEN:-}}"
  if [ -z "$token" ] && command -v gh >/dev/null 2>&1; then
    token="$(gh auth token 2>/dev/null || true)"
  fi
  if [ -n "$token" ]; then
    echo "::add-mask::$token"
    echo "HOMEBREW_GITHUB_API_TOKEN=$token" >> "$GITHUB_ENV"
  fi
fi

if [ "${GITHUB_ACTIONS:-}" = "true" ] && [ "$(uname -s)" = "Linux" ] && ! command -v plutil >/dev/null 2>&1; then
  # Into brew's own bin: brew sanitizes PATH for audit children, so
  # /usr/local/bin is invisible to `/usr/bin/env plutil` there (observed
  # 127 after a verified /usr/local/bin install). The prefix is
  # runner-owned (this script already writes $(brew --repo) unprivileged),
  # so no sudo is needed.
  brew_bin="$(brew --prefix)/bin"
  install -m 0755 "$PWD/scripts/plutil-shim.sh" "$brew_bin/plutil"
  test -x "$brew_bin/plutil" || {
    echo "tap-local: plutil shim install failed" >&2
    exit 1
  }
  echo "tap-local: plutil shim installed (Linux CI)"
fi

if brew tap | grep -q -x "$OUR_TAP"; then
  echo "tap-local: $OUR_TAP ready"
else
  echo "tap-local: $OUR_TAP missing after setup" >&2
  exit 1
fi
