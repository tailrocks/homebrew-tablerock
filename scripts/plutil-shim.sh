#!/usr/bin/env bash
# Minimal plutil subset for `brew audit --cask --online` on Linux runners.
# Installed to /usr/local/bin/plutil by scripts/tap-local.sh (step 4) only
# when running on Linux CI without a real plutil (macOS ships the real one).
#
# Supports exactly what the cask audit invokes:
#   plutil -convert xml1|binary1 -o -|PATH FILE
#   plutil -lint FILE
# Anything else fails closed (exit 1, clear message) — never a silent
# wrong answer. Conversion runs through stdlib plistlib: valid plists
# convert identically, malformed plists fail like the real tool.
#
# DEFERRED ROOT CAUSE: schema-2 generation cannot render the s1 apple leg,
# so no macOS runner covers these casks; remove this shim (and step 4 of
# tap-local.sh) when multi-platform unit legs land in the generator and
# the apple leg returns.
set -euo pipefail

if [ "${1:-}" = "-lint" ] && [ "$#" -eq 2 ]; then
  python3 -c 'import plistlib,sys; plistlib.load(open(sys.argv[1],"rb"))' "$2"
  echo "$2: OK"
  exit 0
fi

if [ "${1:-}" = "-convert" ] && [ "$#" -eq 5 ] && [ "$3" = "-o" ]; then
  case "$2" in
    xml1 | binary1) ;;
    *)
      echo "plutil shim: unsupported format '$2' (want xml1|binary1)" >&2
      exit 1
      ;;
  esac
  python3 - "$2" "$4" "$5" <<'PY'
import plistlib
import sys

fmt = plistlib.FMT_XML if sys.argv[1] == "xml1" else plistlib.FMT_BINARY
with open(sys.argv[3], "rb") as f:
    data = plistlib.load(f)
out = sys.argv[2]
if out == "-":
    plistlib.dump(data, sys.stdout.buffer, fmt=fmt)
else:
    with open(out, "wb") as f:
        plistlib.dump(data, f, fmt=fmt)
PY
  exit 0
fi

echo "plutil shim: unsupported invocation: $*" >&2
exit 1
