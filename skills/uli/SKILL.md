---
name: uli
description: Manual invocation only
---

- if Claude then ~/.claude/CLAUDE.md
- if Codex then ~/.codex/AGENTS.md
- if agy then ~/.gemini/GEMINI.md
- 三者為同一份檔案的 symlink，已在 session 開始時載入，直接引用不重新讀取
