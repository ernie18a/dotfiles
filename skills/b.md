# 決策
- Changes require a net benefit toward the stated goal.
- 每個候選項目的「淨效用」（優點扣除成本）當作縱軸，橫軸為 [你的排序維度]。
- 淨效用的計算方式：[說明優點與成本各如何計量]。
- 淨效用近似常態分布（鐘形曲線）。
- 初步分區保留：淨效用 ≥ 峰值的 60%（μ±1σ 以內）
- 初步分區捨棄：淨效用 < 峰值的 14%（μ±2σ 以外）
- 初步分區其餘：待定
- 刪除測試：對每個「捨棄」項目，確認拿掉後結果不變。若結果會變，改列待定。
- 使用者明確要求的項目一律保留。
- 歸併：相似的項目分成一組，每組只留淨效用最高者，其餘捨棄。
- 依賴：互相依賴的項目視為一個整體評估。
- 重新評分：每確定留下一項後，重算剩餘項目的淨效用。
- 資訊不足：不要猜，列出缺少的資訊，標為待定。
- 輸出：每個項目的淨效用、相對峰值百分比、決策（保留/捨棄/待定）、一句話說明拿掉它的差異。
- 寫不出這句話的項目直接捨棄。

# 規劃
- 刪除測試：刪掉計畫或提案的一個項目後，在已讀到的輸入下，讀者的行動不變，就刪除該項。user 原話要求的項目除外。
- 計畫與提案的每一項附一句刪掉後的差異，引用讀到的檔案行號、原文、執行輸出或 user 原話。寫不出就刪除該項。
- 移除只為推測風險而增加的 plan
- 移除 redundant or semantically overlapping plan
- 移除 defensive plan
- 移除 non-actionable plan
- 移除 conservative-biased plan
- 移除 presence-check、fallback 與 optional 分支的 plan
- 移除 editorial/process residue and extraneous meta-commentary from plan

# 代碼風格
- 預設 fail fast、straight-line programming、branchless programming
- 刪除測試：刪掉程式碼的一個分支、檢查或函式後，在已讀到的輸入下，程式行為不變，就刪除該項。user 原話要求的項目除外。
- 移除只為推測風險而增加的 code
- 移除 redundant or semantically overlapping code
- 移除 defensive code
- 移除 conservative-biased code
- 移除 presence-check、fallback 與 optional 分支的 code
- 移除 editorial/process residue and extraneous meta-commentary from code

# prompt 與文件
- 刪除測試：刪掉文件或 prompt 的一句或一條規則後，在已讀到的輸入下，讀者的行動不變，就刪除該項。user 原話要求的項目除外。
- 移除只為推測風險而增加的 prompt
- 移除 redundant or semantically overlapping prompt
- 移除 defensive prompt
- 移除 non-actionable prompt
- 移除 conservative-biased prompt
- 移除 editorial/process residue and extraneous meta-commentary from prompt
- 僅 prompt：移除 parenthetical 與 semicolon 標點並重組使論述連貫，內容併入主句、拆成獨立句子或刪除
