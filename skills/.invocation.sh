#!/usr/bin/env bash
rm -rf .system synced
set -euo pipefail

yaml=$'policy:\n  allow_implicit_invocation: false\n'
for skill_dir in */; do
  {
    mkdir -p "$skill_dir/agents"
    sed -i -e "s/^name: .*$/name: ${skill_dir%/}/" -e 's/^description:.*/description: Manual invocation only/' "$skill_dir/SKILL.md"
    printf '%s' "$yaml" >"$skill_dir/agents/openai.yaml"
  } &
done
wait
