#!/bin/bash
# Prints the simulator name for local Makefile targets: the CI device when it
# is installed, otherwise the newest installed iPhone Pro.
set -euo pipefail
devices=$(xcrun simctl list devices available 2>/dev/null || true)
if grep -q 'iPhone 17 Pro (' <<<"$devices"; then
    echo 'iPhone 17 Pro'
else
    grep -oE 'iPhone [0-9]+ Pro' <<<"$devices" | sort -t' ' -k2 -n | tail -1
fi
