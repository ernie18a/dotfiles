#!/usr/bin/env bash
set -euo pipefail

for skill_dir in */; do
  mkdir -p "$skill_dir/agents"
  cat >"$skill_dir/agents/openai.yaml" <<'YAML'
policy:
  allow_implicit_invocation: false
YAML
done
sed -i 's/^description:.*/description: Manual invocation only/' */SKILL.md
