---
name: agent
description: Manual invocation only
---

- 將不依賴其他任務輸出、不會產生寫入衝突，且可獨立完成與驗證的任務交派給 sub-agent；啟動時填滿可用並行容量，並在任一 sub-agent 完成後以符合條件的任務立即遞補。

# Sub-agent settings

- 呼叫 `spawn_agent` 時，必須傳入 `fork_turns: "none"`。
