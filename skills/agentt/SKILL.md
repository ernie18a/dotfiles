---
name: agentt
description: Manual invocation only
---

- 遵循 `../agent/SKILL.md` 的調度規則。

# Sub-agent settings

- 呼叫 `spawn_agent` 時，額外傳入 `model: "gpt-5.6-terra"`、`reasoning_effort: "medium"` 與 `fork_turns: "none"`。
