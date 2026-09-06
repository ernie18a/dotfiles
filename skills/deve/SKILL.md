---
name: deve
description: Manual invocation only
---

# 實作規約
- 同時套用 `../subt/SKILL.md`。
- 僅在使用者準許時執行 git 相關指令。
- 修改前完整檢查受影響的程式碼及串接機制；優先重用既有行為、權責抽象或原生能力，以最小變更完整解決根因。
- 僅在使用者分別明確要求時執行非輕量或行為式檢查、為判斷情境使用判斷式，或為腳本提供 Options、Optional Arguments 或 Flags；其餘僅執行輕量、非行為式 static checks 並採用 straight-line programming。
- 輸出新增或修改的非 boilerplate 內容；既有程式碼以函式或區塊為單位。
- 以可局部替換所需的最少模組維持低耦合與明確 I/O 邊界，並優先採用 fail fast、明確契約、靜態型別與顯式轉換。
- 規劃多項實作需求時，按觸碰同一函式的功能聚合排序，範圍由大至小，確保開發連續性。

# 資源

- 以高階並行原語動態調整 CPU 並行規模，使用率約達 85% 即停止擴張，並減少共享可變狀態；在每個批次或迴圈處理節點檢查記憶體，超過門檻時依序縮小批次、延後處理，仍超限才放棄當下任務並釋放資源。

# 專案與執行環境

- 預設使用者提供的輸入存入 `./INPUT/`，指定產出存入 `./OUTPUT/`，程式執行時自動產生的非指定產出存入 `./TMP/`；寫入或更新 `./OUTPUT/` 時，先在同一檔案系統完成暫存產出，再以 atomic replace/switch 一次切換至目標路徑。
- 新增或執行 Python 專案與腳本時，使用 `uv run` 獨立環境；腳本固定以 `uv run <NAME>.py` 執行，必要參數與設定集中定義於腳本最上方、與邏輯分離的 config 區塊。
- 腳本依賴使用 PEP 723 宣告，`requires-python` 上限採最重依賴的最高支援版本，依賴來源限 PyPI 官方發布，且不產生 `.lock`；程式碼僅允許 PEP 723 metadata 註解。
- 僅在 Cargo 原生 config 無法表達需求時新增 Cargo wrapper script。

# situational

- 硬體為 RTX 4050 6G；AI 推論前確認 GPU state 可重用且無殘留張量或 cache，僅允許使用 GPU，否則報錯；Transformers 使用 `dtype`，所有 dtype 必須顯式一致並優先對齊訓練 dtype，來源不明預設 BF16；透過 batch、pipeline、cache 或架構管理 VRAM，不改變既定精度。
- 引入中國 AI 平台套件時，確認模型下載源；海外環境指定 HuggingFace，例如 `hub="hf"`。
