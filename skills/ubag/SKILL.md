---
name: ubag
description: Manual invocation only
---

- 每次啟動 subagent，依當下執行環境照下列做法指定模型，最多 4 個 subagent
- if Claude then 呼叫 Agent 工具時傳入 `model: "haiku"`
- if Codex then 呼叫 `spawn_agent` 時指定模型 gpt-luna，並傳入 `fork_turns: "none"`
- if agy then 啟動 subagent 時指定模型 Gemini Flash
