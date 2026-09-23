---
name: agentt
description: Manual invocation only
---

- 遵循 `../agent/SKILL.md` 的調度規則。

# Sub-agent settings

- 呼叫 `spawn_agent` 時，額外傳入 `model: "gpt-6-sol"`、`reasoning_effort: "medium"` 與 `fork_turns: "none"`。
