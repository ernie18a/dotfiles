---
name: deve
description: Manual invocation only
---
# 實作規約
- 使用本技能時，同時使用 ~/.G/dotfiles/skills/subt/SKILL.md (or `/home/*/.G/dotfiles/skills/subt/SKILL.md`)
- 僅在使用者準許時執行 git 相關指令。
- 以最小變更完整解決需求的根因。
- 除非使用者明確要求，僅執行輕量、非行為式的 static checks。
- 輸出新增或修改的非 boilerplate 內容；既有程式碼以函式或區塊為單位。
- 以可局部替換所需的最少模組拆分，維持低耦合與明確 I/O 邊界。
- 優先 fail fast、明確契約、靜態型別、顯式轉換
- 僅在使用者要求判斷情境時使用判斷式，其餘採 straight-line programming。
- 修改或新增程式碼前，先完整檢查所有受影響的程式碼環節及其串接機制，再開始實作。
- 僅在使用者要求時，為腳本提供 Options、Optional Arguments 或 Flags。
- 規劃多項實作需求時，按觸碰同一函式的功能聚合排序，範圍由大至小，確保開發連續性。
- 修改規格、規約、提示詞或文件時，先刪除、替換與合併，最後才新增。
- CPU：並行規模以硬體使用率為目標動態調整，大約打滿到八成五左右即停止擴張，用高階並行原語管理，共享可變狀態降到最低。
- 記憶體：在每個批次、每輪迴圈處理節點檢查目前用量，超過門檻就依序縮小批次量或延後處理，仍超過上限才放棄當下任務並釋放資源。
- Reuse existing behavior, the responsible abstraction, or native capabilities before adding implementation.
# 專案與執行環境
- 使用者提供的輸入存入 `./INPUT/`，指定產出存入 `./OUTPUT/`，程式執行時自動產生的非指定產出存入 `./TMP/`；寫入或更新 `./OUTPUT/` 時，先在同一檔案系統完成暫存產出，再以 atomic replace/switch 一次切換至目標路徑。
- 新增或執行 Python 專案與腳本時，使用 `uv run` 獨立環境。
- Python 腳本固定以 `uv run <NAME>.py` 執行；必要參數與設定集中定義於腳本最上方獨立且與邏輯分離的 config 區塊。
- 腳本依賴使用 PEP 723 宣告；requires-python 設明確上限，以最重依賴的最高支援版本為準；依賴來源限 PyPI 官方發布；不產生 .lock 檔。
- 程式碼僅允許 PEP 723 metadata 註解。
- 僅在 Cargo 原生 config 無法表達需求時新增 Cargo wrapper script。
# situational
- 硬體為 RTX 4050 6G；AI 推論僅允許使用 GPU，否則報錯。
- Transformers 使用 `dtype`；所有 dtype 必須顯式且一致，推論優先對齊訓練 dtype，來源不明預設 BF16。
- 以記憶體或架構設計處理資源限制，優先透過 batch、pipeline、cache 管理 VRAM，並保持既定精度。
- 推論前確認 GPU state 可重用，且無殘留張量或 cache 干擾。
- 引入中國 AI 平台套件時，確認模型下載源；海外環境指定 HuggingFace，例如 `hub="hf"`。
