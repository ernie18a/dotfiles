#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-$(pwd)}"

skills=(
  comp
  deve
  dual
  lazy
  lg2
  lg34
  norm
  norm2
  os
  readd
  searchr
  subt
  sump
)

for skill in "${skills[@]}"; do
  skill_dir="$ROOT/$skill"
  skill_md="$skill_dir/SKILL.md"
  yaml="$skill_dir/agents/openai.yaml"

  if [[ ! -f "$skill_md" ]]; then
    printf 'skip: %s has no SKILL.md\n' "$skill_dir" >&2
    continue
  fi

  mkdir -p "$skill_dir/agents"

  if [[ ! -f "$yaml" ]]; then
    cat >"$yaml" <<'YAML'
policy:
  allow_implicit_invocation: false
YAML
    printf 'created: %s\n' "$yaml"
    continue
  fi

  if grep -q 'allow_implicit_invocation:' "$yaml"; then
    sed -i -E 's/^([[:space:]]*)allow_implicit_invocation:[[:space:]]*.*/\1allow_implicit_invocation: false/' "$yaml"
    printf 'updated: %s\n' "$yaml"
    continue
  fi

  if grep -q '^policy:[[:space:]]*$' "$yaml"; then
    awk '
      BEGIN { inserted = 0 }
      /^policy:[[:space:]]*$/ && !inserted {
        print
        print "  allow_implicit_invocation: false"
        inserted = 1
        next
      }
      { print }
    ' "$yaml" >"$yaml.tmp"
    mv "$yaml.tmp" "$yaml"
    printf 'updated: %s\n' "$yaml"
    continue
  fi

  cat >>"$yaml" <<'YAML'

policy:
  allow_implicit_invocation: false
YAML
  printf 'appended: %s\n' "$yaml"
done
