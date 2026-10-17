#!/usr/bin/env bash
# verify.sh — check every origin and every commission pack in this vault.
# Rule: an origin's bytes on disk must match the SHA-256 recorded beside it.
# A commission pack carries files.sha256 (paths relative to the pack folder).
# Authoritative check: `sha256sum -c` (GNU coreutils). This script only loops over the folders.
# Usage: bash tools/verify.sh [vault-root]

set -u

root="${1:-.}"
fail=0
count=0
packs=0

for dir in "$root"/origins/*/; do
  [ -d "$dir" ] || continue
  count=$((count + 1))
  if [ ! -f "${dir}origin.sha256" ]; then
    echo "MISSING hash file: ${dir}"
    fail=1
    continue
  fi
  if (cd "$dir" && sha256sum -c --status origin.sha256); then
    echo "ok    ${dir}"
  else
    echo "FAIL  ${dir}"
    fail=1
  fi
done

for dir in "$root"/commissions/*/; do
  [ -d "$dir" ] || continue
  packs=$((packs + 1))
  if [ ! -f "${dir}files.sha256" ]; then
    echo "MISSING files.sha256: ${dir}"
    fail=1
    continue
  fi
  if (cd "$dir" && sha256sum -c --status files.sha256); then
    echo "ok    ${dir}"
  else
    echo "FAIL  ${dir}"
    fail=1
  fi
done

echo "checked ${count} origin(s), ${packs} commission pack(s)"
if [ "$count" -eq 0 ] && [ "$packs" -eq 0 ]; then
  echo "nothing to check yet"
fi
exit "$fail"
