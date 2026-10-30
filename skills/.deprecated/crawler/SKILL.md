---
name: crawler
description: Manual invocation only
disable-model-invocation: true
---

- 同時套用 `../deve/SKILL.md`。
- 下載或爬取不變動的資料時，單一單位失敗即靜默略過，以 atomic replace 寫出的檔案作為完成標記，重複執行即補抓缺漏，此情境不受 fail fast 與 no presence-check 限制。
