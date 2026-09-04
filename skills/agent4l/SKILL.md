---
name: agent4l
description: Manual invocation only
---

# Purpose

- 同時協調最多 3 個 sub-agent；有剩餘任務時，任一完成後即遞補。

# Sub-agent settings

- 呼叫 `spawn_agent` 時，必須傳入 `model: "gpt-5.6-luna"`、`reasoning_effort: "xhigh"` 與 `fork_turns: "none"`。
