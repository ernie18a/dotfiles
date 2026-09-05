---
name: agent4
description: Manual invocation only
---

# Purpose

- 同時協調指定數量的 sub-agent；有剩餘任務時，任一完成後即遞補。

# Sub-agent settings

- 呼叫 `spawn_agent` 時，必須傳入 `fork_turns: "none"`。
