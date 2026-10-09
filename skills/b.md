# foundation
- Changes require a net benefit toward the stated goal.
- 刪除測試：刪掉一項後，在已讀到的輸入下，程式行為或讀者的行動不變，就刪除該項。user 原話要求的項目除外。
- 移除只為推測風險而增加的內容
- 移除 redundant or semantically overlapping 內容
- 移除 defensive 內容
- 移除 non-actionable 內容
- 移除 conservative-biased 內容
- 移除 presence-check、fallback 與 optional 分支
- 移除 editorial/process residue and extraneous meta-commentary

# 決策
- 使用該技能時同時使用 foundation skill
- 每個候選項目的「淨效用」（優點扣除成本）當作縱軸，橫軸為 [你的排序維度]。
- 淨效用的計算方式：[說明優點與成本各如何計量]。
- 淨效用近似常態分布（鐘形曲線）。
- 初步分區保留：淨效用 ≥ 峰值的 60%（μ±1σ 以內）
- 初步分區捨棄：淨效用 < 峰值的 14%（μ±2σ 以外）
- 初步分區其餘：待定
- 對每個「捨棄」項目，確認拿掉後結果不變。若結果會變，改列待定。
- 歸併：相似的項目分成一組，每組只留淨效用最高者，其餘捨棄。
- 依賴：互相依賴的項目視為一個整體評估。
- 重新評分：每確定留下一項後，重算剩餘項目的淨效用。
- 資訊不足：不要猜，列出缺少的資訊，標為待定。
- 輸出：每個項目的淨效用、相對峰值百分比、決策（保留/捨棄/待定）、一句話說明拿掉它的差異。
- 寫不出這句話的項目直接捨棄。

# 規劃
- 使用該技能時同時使用 foundation skill
- 刪除測試的一項指計畫與提案的一個項目。
- 計畫與提案的每一項附一句刪掉後的差異，引用讀到的檔案行號、原文、執行輸出或 user 原話。寫不出就刪除該項。

# 代碼風格
- 使用該技能時同時使用 foundation skill
- 刪除測試的一項指程式碼的一個分支、檢查或函式。
- 預設 fail fast、straight-line programming、branchless programming

# prompt 與文件
- 使用該技能時同時使用 foundation skill
- 刪除測試的一項指文件與 prompt 的一句或一條規則。
- 僅 prompt：移除 parenthetical 與 semicolon 標點並重組使論述連貫，內容併入主句、拆成獨立句子或刪除
