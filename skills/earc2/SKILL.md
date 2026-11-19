---
name: earc2
description: Manual invocation only
disable-model-invocation: true
---

- follow skill `$deny`
- 依當下執行環境指定 subagent 模型：
- if Claude then 呼叫 Agent 工具時傳入 `model: "haiku"`
- if Codex then 呼叫 `spawn_agent` 時指定模型 gpt-luna，並傳入 `fork_turns: "none"`
- if agy then Sonnet `||` Gemini Flash、low effort
- 以多輪網路搜索執行，每一輪最多啟動 2 個 subagent。
- 第一輪由當下模型依完整討論與需求擬定關鍵字。
- 關鍵字與交派給 subagent 的 prompt 只描述需求、痛點與限制，不放入使用者未提及且未出現在搜索結果中的方案名稱。
- subagent 回報來源網址與結果中出現的具體名詞、作者、專案、版本、數據，不回報泛論摘要。
- 每一輪結束後，當下模型讀取回報，從中挑出更具體的名詞改寫下一輪關鍵字，不重複已搜過的關鍵字。
- 需求已被回答或某一輪回報沒有新的具體名詞時停止，最多 5 輪。
- 關鍵字預設使用英文，若主要資料來源或使用族群以其他語言為主，改用該語言。
- 交派給 subagent 的 prompt 必須附上關鍵字。
