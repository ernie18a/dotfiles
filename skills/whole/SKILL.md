---
name: whole
description: Manual invocation only
disable-model-invocation: true
---

# 目的
- 把大量 Markdown 文件事先轉成表格與分群，讓之後的對話以程式查詢全庫，不靠模型讀取或記憶全部內容。
- 用法：`/whole <來源資料夾> <工作資料夾>`。來源只取頂層 `*.md`。

# 執行
- 腳本一律以 `uv run --no-project <本技能目錄>/scripts/main.py` 執行，執行前取得使用者允許。
- 模型呼叫全部由 `scripts/dispatch.py` 以 `claude -p` 逐單位執行，每單位一個獨立上下文；本對話不逐份閱讀全庫。
- 中斷後重跑同一指令即從未完成的單位接續。

# 建表
- 隨機抽樣約 30 份文件閱讀，定義扁平欄位，值域能封閉的一律用封閉清單。
- 寫 `<工作>/extract/prompt.md`：說明要抽取什麼、每列一個獨立資訊單位、欄位定義與值域。輸入是帶行號的原文，每行格式為「行號 Tab 原文」。
- 寫 `<工作>/extract/schema.json`：JSON Schema，頂層物件只有 `rows` 陣列；每列必含整數 `line` 與字串 `quote`（原文逐字摘錄），其餘為欄位，封閉清單用 `enum`，可空欄位允許 `null`，`additionalProperties` 為 false。
- 先試跑 3 個單位並檢查 `<工作>/extract/out/` 的輸出：`uv run --no-project <本技能目錄>/scripts/units.py <來源> | head -3 | uv run --no-project <本技能目錄>/scripts/dispatch.py <工作>/extract/prompt.md <工作>/extract/schema.json <工作>/extract/out`。通過後執行 `main.py extract <來源> <工作>`。
- 流程依序為切單位、抽取、補抽遺漏、載入 `facts` 表、核對。核對失敗時依錯誤訊息修正 prompt 或把錯誤單位的輸出檔移至 `/tmp/` 後重跑，直到通過。

# 分群
- 從 `facts` 抽樣數百列，歸納分類體系：每群一個代號、核心邏輯、可選變體，另設一個「其他」群。
- 寫 `<工作>/clusters/prompt.md`：分類體系全文與判定規則。輸入是 Tab 分隔表格，首行為欄名。
- 寫 `<工作>/clusters/schema.json`：每列含 `ref`（輸入的 `id`）、`cluster`（代號 `enum`）、`note`（與群內核心邏輯的差異）。
- 執行 `main.py judge <工作> clusters "SELECT id, <判斷所需欄位> FROM facts"`。
- 「其他」群超過總列數 5% 時，從中抽樣擴充分類體系，把 `<工作>/clusters/out` 移至 `/tmp/` 後重跑。

# 產物
- `<工作>/db.sqlite`：`units`、`facts`、`clusters` 等表。
- `<工作>/USAGE.md`：之後對話的查詢規則，由 extract 產生。新對話只需讀它。
