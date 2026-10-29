# 資料
- 原文：`{src}/*.md`。
- `{w}/db.sqlite`
  - `units`：id、path、first、last，原文切成的處理單位與行範圍。
  - `facts`：id、unit、line、quote 與各欄位，欄位定義見 `{w}/extract/prompt.md`。
  - `clusters`：ref（對應 facts.id）、cluster、note，分類體系見 `{w}/clusters/prompt.md`。
  - 其他表：`{w}/<表名>/prompt.md` 為其定義。
- 每張表都已由程式核對覆蓋全部原文或全部輸入列。

# 規則
- 牽涉全體的問題一律以 `sqlite3` 查詢作答，不直接閱讀原文歸納。原文只用於引用查證，以 facts 的 path 與 line 定位。
- 依序嘗試：查 `clusters` 與 `facts`；需要語意判斷時用 judge；欄位沒涵蓋時用 scan。
- 對話中一次閱讀的查詢結果不超過 100 列，超過時改用 judge 分批處理。
- 回答附覆蓋數：納入的檔案數與列數。

# 語意判斷
- 寫 `{w}/<名稱>/prompt.md` 與 `{w}/<名稱>/schema.json`，schema 頂層為 `rows` 陣列，每列必含 `ref`（輸入的 `id`）。
- 執行 `uv run --no-project {main} judge {w} <名稱> "<SQL，第一欄為 id>"`，結果在表 `<名稱>`，程式已核對每個輸入列恰有一筆判定。

# 新欄位
- 寫 `{w}/<名稱>/prompt.md` 與 `{w}/<名稱>/schema.json`，每列必含 `line` 與 `quote`。
- 執行 `uv run --no-project {main} scan {src} {w} <名稱>`，對全部單位逐一抽取，結果在表 `<名稱>`，以 unit 與 line 對應 facts。
- 執行前取得使用者允許。
