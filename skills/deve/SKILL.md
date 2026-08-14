---
name: deve
description: Manual invocation only
---

# 實作規約
- 使用本技能時，同時使用 skill `$subt`。
- 人工智慧模組沒有權限執行 git 相關指令，除非使用者準許。
- 只做解決需求的最小變更；不過度設計、不做推測性實作。
- 預設僅執行輕量、非行為式的 static checks；其他驗證僅在使用者明確要求時執行。
- 只輸出新增或修改的部分；修改既有程式碼時，只輸出該函式或區塊，不輸出 boilerplate。
- 優先低耦合與明確 I/O 邊界，讓變動點可局部替換；不為形式過度拆模組。
- 優先 fail fast、明確契約、靜態型別、顯式轉換
- Straight-line programming, 除非無法運作, 盡量不使用判斷式
- 修改或新增程式碼前，先完整檢查所有受影響的程式碼環節及其串接機制，再開始實作。
- 所有腳本預設禁止使用" Options / Optional Arguments / Flag ", 除非使用者要求 
- 規劃多項實作需求時，按觸碰同一函式的功能聚合排序，範圍由大至小，確保開發連續性。
- 修改規格、規約、提示詞或文件時，先刪除、替換與合併，最後才新增。

# 專案與執行環境
- 將外部輸入存入 `INPUT/`，最終成果存入 `OUTPUT/`，程式產生的非最終檔案存入 `TMP/`，`config.*` 存於專案根目錄。
- 新增或執行 Python 專案與腳本時，使用 `uv run` 獨立環境。
- Python 腳本固定以 `uv run <NAME>.py` 執行；必要參數與設定定義於腳本內，不透過 command-line arguments 或 flags 傳入。
- 腳本依賴使用 PEP 723 宣告；`requires-python` 設明確上限，以最重依賴的最高支援版本為準；優先官方 wheel，僅在 PyPI 缺失必要功能時使用 Git source。
- 禁止新增 Cargo wrapper script，除非 Cargo 原生 config 無法表達需求。

# situational
- 硬體為 RTX 4050 6G；AI 推論強制使用 GPU，使用 CPU 即報錯。
- Transformers 使用 `dtype`，不用已棄用的 `torch_dtype`；dtype 必須顯式指定且一致，推論優先對齊訓練 dtype，來源不明預設 BF16；不得隱式混合 dtype。
- 不以降精度替代記憶體或架構設計；優先透過 batch、pipeline、cache 管理 VRAM。
- 推論前確認 GPU state 可重用，且無殘留張量或 cache 干擾。
- 引入中國 AI 平台套件時，確認模型下載源；海外環境指定 HuggingFace，例如 `hub="hf"`。
- CPU： 並行規模以硬體使用率為目標動態調整，大約打滿到八成五左右即停止擴張，用高階並行原語管理，共享可變狀態降到最低。
- 記憶體： 在每個批次、每輪迴圈處理節點檢查目前用量，超過門檻就依序縮小批次量或延後處理，仍超過上限才放棄當下任務並釋放資源。
