#!/usr/bin/env bash
for R in /g/*/ ~/.G/*/; do (
  R=${R%/}; N=$(basename "$R"); T=$(date +%s)
  U=$(git -C "$R" remote get-url origin) || exit
  git clone -q --no-checkout --depth 1 --filter=blob:none "$U" "/tmp/$N.fresh.$T" &&
  mv "$R/.git" "/tmp/$N.broken.$T.git" &&
  mv "/tmp/$N.fresh.$T/.git" "$R/.git" &&
  git -C "$R" reset -q
) & done; wait
