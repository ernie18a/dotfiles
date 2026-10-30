---
name: earc
description: Manual invocation only
disable-model-invocation: true
---

- 由當下模型依完整討論與需求擬定搜索關鍵字，再啟動最多 4 個 subagent 執行網路搜索。
- 依當下執行環境指定 subagent 模型：
- if Claude then 呼叫 Agent 工具時傳入 `model: "haiku"`
- if Codex then 呼叫 `spawn_agent` 時指定模型 gpt-luna，並傳入 `fork_turns: "none"`
- 關鍵字以面向表呈現，每列為一個面向名稱與其關鍵字。
- 使用者指定的條件為所有列共用。其餘關鍵字不得在兩列重複，也不得只是另一列關鍵字的改寫。
- 關鍵字預設使用英文，若主要資料來源或使用族群以其他語言為主，改用該語言。
- 每個 subagent 只負責一列。交派給 subagent 的 prompt 必須附上該列關鍵字、其他列的非共用關鍵字作為禁用清單，以及 `$deny` 全文。
