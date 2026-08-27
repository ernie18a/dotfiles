---
name: agent4t
description: Manual invocation only
---

# Purpose

- 在同一個 session 中協調 sub-agent，最多同時 4 個；任一sub-agent完成任務後, 啟動下一個來執行剩下的任務，直到工作完成。

# Sub-agent settings

- 每次呼叫 `spawn_agent` 時，一律明確傳入 `model: "gpt-5.6-terra"`、`reasoning_effort: "high"` 與 `fork_turns: "none"`。
- 不得省略上述參數或改用主 agent 的繼承值。
