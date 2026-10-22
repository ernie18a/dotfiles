#!/usr/bin/env bash
# skill 使用次數，由少到多
S=~/.G/dotfiles/skills
{
  tr -d '\0' < ~/.claude/history.jsonl | jq -r '.display | gsub("\n"; " ")'
  tr -d '\0' < ~/.codex/history.jsonl | jq -r '.text | gsub("\n"; " ")'
  tr -d '\0' < ~/.gemini/antigravity-cli/history.jsonl | jq -r '.display | gsub("\n"; " ")'
} | grep -oE '^\s*/[A-Za-z][[:alnum:]_:-]*|(^|\s)\$[A-Za-z][[:alnum:]_:-]*|\[\$[^]]+\]' \
  | tr -d ' \t/$[]' | grep -xFf <(ls "$S") | sort | uniq -c | sort -n
