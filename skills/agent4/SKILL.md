---
name: agent4
description: Manual invocation only
---

# Purpose

- 在同一個 session 中協調 sub-agent，最多同時 4 個；任一sub-agent完成任務後, 啟動下一個來執行剩下的任務，直到工作完成。

# Sub-agent settings

- 每次呼叫 `spawn_agent` 時，一律明確傳入 `fork_turns: "none"`。
