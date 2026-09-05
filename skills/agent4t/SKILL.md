---
name: agent4t
description: Manual invocation only
---

# Purpose

- 啟動時，將可獨立完成、不依賴其他任務輸出、不與其他任務產生寫入衝突，且能產出可獨立驗證結果的任務，交派給盡可能多的 sub-agent，直到用盡可用並行容量或沒有符合條件的任務。
- 任一 sub-agent 完成後，若仍有符合條件的任務，立即遞補。

# Sub-agent settings

- 呼叫 `spawn_agent` 時，必須傳入 `model: "gpt-5.6-terra"`、`reasoning_effort: "high"` 與 `fork_turns: "none"`。
