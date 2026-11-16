---
name: earc
description: Manual invocation only
disable-model-invocation: true
---

- follow skill `$deny`
- 由當下模型依完整討論與需求擬定搜索關鍵字，再啟動最多 4 個 subagent 執行網路搜索。
- 依當下執行環境指定 subagent 模型：
- if Claude then 呼叫 Agent 工具時傳入 `model: "haiku"`
- if Codex then 呼叫 `spawn_agent` 時指定模型 gpt-luna，並傳入 `fork_turns: "none"`
- if agy then  Sonnet `||`  Gemini Flash、low effort
- 關鍵字預設使用英文，若主要資料來源或使用族群以其他語言為主，改用該語言。
- 交派給 subagent 的 prompt 必須附上關鍵字
