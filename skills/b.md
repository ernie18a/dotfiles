---
name: deve
description: Manual invocation only
---

# 實作流程
- 先用 `../subt/SKILL.md` 規劃 
- 修改或新增程式碼前，先完整檢查所有受影響的程式碼環節及其串接機制，再開始實作。
- 規劃多項實作需求時，按觸碰同一函式的功能聚合排序，範圍由大至小，確保開發連續性。
- 僅執行 static checks、dependency resolution 與 declared-vs-imported consistency.
- Python 以 uv pip compile --only-binary :all: 僅讀 metadata 解析版本,type check 僅針對專案自身程式碼.

# 開發規范 
- 將具有獨立變更原因的職責拆成獨立 executable（stage）；每個 stage 須可獨立執行、測試或替換，並僅透過 stdin/stdout/file/pipe 與其他 stage 協作，組合成 pipeline。再透過執行單一主要腳本呼叫其他腳本.
- 預設 fail fast、straight-line programming、branchless programming
- 明確契約、靜態型別、顯式轉換。
- 預設不使用 Options、Optional Arguments 或 Flags。

# misc
- 輸出新增或修改的非 boilerplate 內容
- 完成任務後只能回復 `DONE`, 不回復其他資訊
- 以最小變更完整解決需求根因。

# 專案與執行環境
- Python 程式碼除 PEP 723 metadata 外，不得包含任何註解或 docstring。
- 腳本依賴使用 PEP 723 宣告；requires-python 設明確上限，以最重依賴的最高支援版本為準；依賴來源限 PyPI 官方發布；不產生 .lock 檔。
- 僅在 Cargo 原生 config 無法表達需求時新增 Cargo wrapper script。

# 預設位置
- `./INPUT/` 裡有 user 提供的檔案, 腳本存取時不針對檔案名稱
- `./TMP/` 存放暫存檔, 中間檔與以 atomic replace 切換至 `./OUTPUT/` 的檔案, `./OUTPUT/` 存放 user 要求的檔案
- 可調整參數集中放 `./conf.toml`, 若是對應的副檔名
- ./DATA/ 預設不存在 , 底下只存放被entry script 觸發的腳本

# situational
- 硬體為 RTX 4050 6G；AI 推論僅允許使用 GPU，否則報錯。
- Transformers 使用 dtype；所有 dtype 必須顯式且一致，推論優先對齊該模型官方訓練時所用的 dtype；來源不明時查證模型卡/原始碼確認訓練 dtype
- 引入中國 AI 平台套件時，確認模型下載源；海外環境指定 HuggingFace，例如 `hub="hf"`。
- CPU：並行規模以硬體使用率為目標動態調整，大約打滿到八成五左右即停止擴張，用高階並行原語管理，共享可變狀態降到最低。
- 記憶體：在每個批次、每輪迴圈處理節點檢查目前用量，超過門檻就依序縮小批次量或延後處理，仍超過上限才放棄當下任務並釋放資源。
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
