---
name: subt
description: Manual invocation only
---

以下規則適用於程式碼、文件、prompt、計畫、規劃過程與提案。

刪除測試：刪掉一項後，在已讀到的輸入下，程式行為或讀者的行動不變，就刪除該項。user 原話要求的項目除外。一項指程式碼的一個分支、檢查或函式，文件與 prompt 的一句或一條規則，計畫與提案的一個項目。

計畫與提案的每一項附一句刪掉後的差異，引用讀到的檔案行號、原文、執行輸出或 user 原話。寫不出就刪除該項。

最常通不過刪除測試的類別：
- 只為推測風險而增加的內容
- redundant or semantically overlapping 內容
- defensive 內容
- non-actionable 內容
- conservative-biased 內容
- presence-check、fallback 與 optional 分支
- editorial/process residue and extraneous meta-commentary

prompt 另外移除 parenthetical 與 semicolon 標點並重組使論述連貫，內容併入主句、拆成獨立句子或刪除。
