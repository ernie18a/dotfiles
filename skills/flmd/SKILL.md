---
name: flmd
description: Manual invocation only
---

- 同時套用 `../deve/SKILL.md`。
- if 使用者指定檔案 then 處理該檔案
- else 比較當前目錄的 `./log` 與所有 `os*.md` 的修改時間，取最新的一個
  - if 最新為 `os*.md` then 執行該檔案內容
  - if 最新為 `./log` then 修正該檔案記錄的問題。`./log` 為無副檔名純文字檔案
