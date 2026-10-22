#!/usr/bin/env bash
# bash_profile 的 alias/函式在 bash_history 中的使用次數
export LC_ALL=C
H=~/.bash_history
P=~/.G/dotfiles/home/.bash_profile

j=$(join -a1 -e0 -o 0,2.2 \
  <(grep -oE '^alias +[A-Za-z0-9_.]+=|^[A-Za-z0-9_]+\(\)' "$P" | sed -E 's/^alias +//; s/[=()]+$//' | sort -u) \
  <(grep -av -E '^[[:space:]]*(#[0-9]+)?[[:space:]]*$' "$H" | awk '{print $1}' | sort | uniq -c | awk '{print $2, $1}' | sort))

echo "=== 從未使用 ==="
grep -Ef <(awk '$2==0 {print "^alias +" $1 "=|^" $1 "\\(\\)"}' <<<"$j") "$P"

echo
echo "=== 有使用，由少到多排序，最常用的留在畫面最下面 ==="
awk '$2>0 {printf "%6d  %s\n", $2, $1}' <<<"$j" | sort -n
