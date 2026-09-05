---
name: agent4
description: Manual invocation only
---

# Purpose

- 依當次 session prompt 指定的數量同時協調 sub-agent；有剩餘任務時，任一完成後即遞補。

# Sub-agent settings

- 呼叫 `spawn_agent` 時，必須傳入 `fork_turns: "none"`。
