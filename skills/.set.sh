#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-$(pwd)}"

for skill_dir in "$ROOT"/*/; do
  mkdir -p "$skill_dir/agents"
  cat >"$skill_dir/agents/openai.yaml" <<'YAML'
policy:
  allow_implicit_invocation: false
YAML
done
