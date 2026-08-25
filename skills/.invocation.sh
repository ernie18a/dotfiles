#!/usr/bin/env bash
rm -rf .system
set -euo pipefail

for skill_dir in */; do
  skill_name="${skill_dir%/}"
  sed -i "s/^name: .*$/name: $skill_name/" "$skill_dir/SKILL.md"
  mkdir -p "$skill_dir/agents"
  cat >"$skill_dir/agents/openai.yaml" <<'YAML'
policy:
  allow_implicit_invocation: false
YAML
done
sed -i 's/^description:.*/description: Manual invocation only/' */SKILL.md
