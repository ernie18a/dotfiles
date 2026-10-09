---
name: deve
description: Manual invocation only
---

- 預設 fail fast、straight-line programming、branchless programming
---
name: normald
description: Manual invocation only
---

請把每個候選項目的「淨效用」（優點扣除成本）當作縱軸，橫軸為 [你的排序維度]。
淨效用的計算方式：[說明優點與成本各如何計量]。
淨效用近似常態分布（鐘形曲線）。

初步分區：
- 保留：淨效用 ≥ 峰值的 60%（μ±1σ 以內）
- 捨棄：淨效用 < 峰值的 14%（μ±2σ 以外）
- 其餘：待定

再用以下規則修正：
1. 刪除測試：對每個「捨棄」項目，確認拿掉後結果不變。若結果會變，改列待定。使用者明確要求的項目一律保留。
2. 歸併：相似的項目分成一組，每組只留淨效用最高者，其餘捨棄。
3. 依賴：互相依賴的項目視為一個整體評估。
4. 重新評分：每確定留下一項後，重算剩餘項目的淨效用。
5. 資訊不足：不要猜，列出缺少的資訊，標為待定。

輸出：每個項目的淨效用、相對峰值百分比、決策（保留/捨棄/待定）、一句話說明拿掉它的差異。寫不出這句話的項目直接捨棄。
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
---
name: subt2
description: Manual invocation only
---

- Changes require a net benefit toward the stated goal.
- 移除 redundant or semantically overlapping code/prompt/plan
- 移除 defensive code/prompt/plan
- 移除 non-actionable prompt/plan
- 移除 conservative-biased code/prompt/plan
- 移除 presence-check、fallback 與 optional 分支的 code/plan
- 移除 editorial/process residue and extraneous meta-commentary from code/prompt/plan
- 移除 parenthetical 與 semicolon 標點 from prompt 並重組使論述連貫,內容併入主句、拆成獨立句子或刪除
