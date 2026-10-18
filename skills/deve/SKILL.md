---
name: deve
description: Manual invocation only
---

- 同時使用 `~/.G/dotfiles/skills/name/SKILL.md`
# Plan
- 修改或新增程式碼前，先完整檢查所有受影響的程式碼環節及其串接機制，再開始實作。
- 規劃多項實作需求時，按觸碰同一函式的功能聚合排序，範圍由大至小，確保開發連續性。
- 以最小變更完整解決需求根因。

# Build
- 將具有獨立變更原因的職責拆成獨立 executable（stage）；每個 stage 須可獨立執行、測試或替換，並僅透過 stdin/stdout/file/pipe 與其他 stage 協作，組合成 pipeline。再透過執行單一主要腳本呼叫其他腳本.
- 明確契約、靜態型別、顯式轉換。
- 使用 fail fast、straight-line programming
- no presence-check
- 預設不使用 Options、Optional Arguments 或 Flags。
- Python 程式碼除 PEP 723 metadata 外，不得包含任何註解或 docstring。
- 腳本依賴使用 PEP 723 宣告；requires-python 設明確上限，以最重依賴的最高支援版本為準；依賴來源限 PyPI 官方發布；不產生 .lock 檔。
- 僅在 Cargo 原生 config 無法表達需求時新增 Cargo wrapper script。

# Places
- `./` 頂層只放以下項目，工具無法變更位置的項目例外
  - entry script：使用者直接執行的腳本
  - `./DATA/conf2.*`：存放不需要頻繁切換的 parameter
  - `./conf.*`：存放使用者有提到而且需要 user 頻繁切換的 parameter
  - `./INPUT/`：user 手動提供提供的檔案的存放位置，非永久保存區, 腳本存取時不針對檔案名稱  
  - `./TMP/`：中間檔與以 atomic replace 切換至 `./OUTPUT/` 的檔案. 所有非業務代碼暫存檔 or 輕量級測試的暫存檔存放位置
  - `./OUTPUT/`：user 要求的檔案
  - `./DATA/`：其餘檔案與資料夾不論類型一律放這裡，不沿用語言或框架慣例的根目錄位置

# Machine
- AI 推論僅允許使用 GPU，否則報錯。
- 執行環境只有 Colab T4 與 RTX 4050 兩種，程式以 `"T4" in torch.cuda.get_device_name(0)` 判斷，不處理其他 GPU。
- dtype 一律顯式且一致，Transformers 以 dtype 參數指定。
- 推論採用模型官方推論程式碼的預設 dtype，官方未提供時查證模型卡或原始碼的訓練 dtype。
- dtype：T4 用 fp32，RTX 4050 用官方預設 dtype。
- VRAM 上限：T4 為 15GB，RTX 4050 為 6GB，模型、批次與快取的總用量不得超過所在環境上限。
- CPU：並行規模以硬體使用率為目標動態調整，大約打滿到八成五左右即停止擴張，用高階並行原語管理，共享可變狀態降到最低。
- 記憶體：在每個批次、每輪迴圈處理節點檢查目前用量，超過門檻就依序縮小批次量或延後處理，仍超過上限才放棄當下任務並釋放資源。

# Misc
- 僅執行 static checks、dependency resolution 與 declared-vs-imported consistency.
- Python 以 uv pip compile --only-binary :all: 僅讀 metadata 解析版本,type check 僅針對專案自身程式碼.
- 引入中國 AI 平台套件時，確認模型下載源；海外環境指定 HuggingFace，例如 `hub="hf"`。
- 完成任務後只能回復 `DONE`, 不回復其他資訊
