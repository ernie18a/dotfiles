#!/usr/bin/env bash
set -e
HISTORY_FILE=~/.bash_history
PROFILE_FILE=~/.G/dotfiles/home/.bash_profile
WORKDIR=$(mktemp -d)

grep -av -E '^[[:space:]]*(#[0-9]+)?[[:space:]]*$' "$HISTORY_FILE" \
    | sed -E 's/^[[:space:]]+//' \
    | awk '{print $1}' \
    | sort \
    | uniq -c \
    | sort -rn \
    > "$WORKDIR/freq_all.txt"

grep -oE '^alias +[A-Za-z0-9_.]+=' "$PROFILE_FILE" \
    | sed -E 's/^alias +//; s/=$//' > "$WORKDIR/names.txt"
grep -oE '^[A-Za-z0-9_]+\(\)' "$PROFILE_FILE" \
    | sed -E 's/\(\)//' >> "$WORKDIR/names.txt"
sort -u "$WORKDIR/names.txt" -o "$WORKDIR/names.txt"

while read -r name; do
    count=$(awk -v n="$name" '$2==n{print $1; exit}' "$WORKDIR/freq_all.txt")
    echo "${count:-0} $name"
done < "$WORKDIR/names.txt" > "$WORKDIR/joined.txt"

echo "=== 從未使用 ==="
awk '$1==0{print $2}' "$WORKDIR/joined.txt" | sort | while read -r name; do
    esc_name=$(printf '%s' "$name" | sed -E 's/[][(){}.^$*+?\\|]/\\&/g')
    grep -E "^alias +${esc_name}=|^${esc_name}\(\)" "$PROFILE_FILE"
done

echo
echo "=== 有使用，由少到多排序，最常用的留在畫面最下面 ==="
awk '$1>0' "$WORKDIR/joined.txt" | sort -n | awk '{printf "%6d  %s\n", $1, $2}'

rm -rf "$WORKDIR"
