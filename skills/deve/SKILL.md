---
name: deve
description: Manual invocation only
---

# 實作流程
- 同時套用 `../subt/SKILL.md`。
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
- 預設讀取 `./INPUT/` 內所有相符類型的檔案，無需指定檔案名稱；使用者提供的輸入存入 `./INPUT/`，產出存入 `./OUTPUT/`，程式執行時自動產生的產出存入 `./TMP/`；寫入或更新 `./OUTPUT/` 時，先在同一檔案系統完成暫存產出，再以 atomic replace/switch 一次切換至目標路徑。可調整參數集中放 `./conf.toml` 若是對應的副檔名 

# situational
- 硬體為 RTX 4050 6G；AI 推論僅允許使用 GPU，否則報錯。
- Transformers 使用 dtype；所有 dtype 必須顯式且一致，推論優先對齊該模型官方訓練時所用的 dtype；來源不明時查證模型卡/原始碼確認訓練 dtype
- 引入中國 AI 平台套件時，確認模型下載源；海外環境指定 HuggingFace，例如 `hub="hf"`。
- CPU：並行規模以硬體使用率為目標動態調整，大約打滿到八成五左右即停止擴張，用高階並行原語管理，共享可變狀態降到最低。
- 記憶體：在每個批次、每輪迴圈處理節點檢查目前用量，超過門檻就依序縮小批次量或延後處理，仍超過上限才放棄當下任務並釋放資源。
