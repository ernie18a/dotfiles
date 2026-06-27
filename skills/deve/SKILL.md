---
name: deve
description: 實作、修改或執行程式，建立或調整專案，或處理 Python、Rust、GPU 推論時使用。
---
# 開發規約

- 只做解決需求的最小變更；不過度設計、不做推測性實作。
- 只輸出新增或修改的部分；修改既有程式碼時，只輸出該函式或區塊，不輸出 boilerplate。
- 優先低耦合與明確 I/O 邊界，讓變動點可局部替換；不為形式過度拆模組。
- 優先 fail fast、明確契約、可驗證型別與顯式轉換；測試優先覆蓋高風險與核心邊界。

# 驗證規約

- 修改程式碼後，必須執行該專案的 canonical 測試/檢查指令（如 `uv run pytest -q`、`cargo test`、`npm test`），並以其結果判定是否完成驗證。專案規格（如 `*NN.md`）中指定的驗證指令優先；無指定時，從 `pyproject.toml`、`Cargo.toml`、`package.json` 等專案清單推斷 canonical 指令。

- 禁止以 ad-hoc 驗證、手動實驗或自我述句（「應已正確」）替代正式測試套件。
- 禁止將局部驗證路徑的通過當作 full-suite 綠燈。
- 只有在 canonical 測試無法直接覆蓋改動邊界，或 system 明確要求 fresh verification evidence 時，才進行 ad-hoc verification。其內容必須只驗 changed behavior，且失敗時能明確失敗；不得取代 canonical 測試。

# I/O 與寫入隔離
- `/g` 是外接硬碟。工作專案、輸入、輸出、暫存檔、快取、下載物、模型權重、瀏覽器 binaries、build artifacts 與工具索引，預設都必須在 `/g`；不得寫入作業系統硬碟。
- 專案內 `INPUT/` 存原始輸入，`OUTPUT/` 存最終輸出，`TMP/` 存中間檔。
- 全域可重建的快取與下載物放在 `/g/.TMP/`，禁止 fallback 到 `~/`、`/tmp`、`~/.cache`。

# Python 執行環境
- 新增或執行 Python 專案與腳本時，使用 `uv run` 獨立環境。
- 每個專案根目錄須有 `uv.toml`，並設定 `python-preference = "only-managed"`。
- 腳本依賴使用 PEP 723 宣告；`requires-python` 設明確上限，以最重依賴的最高支援版本為準；優先官方 wheel，僅在 PyPI 缺失必要功能時使用 Git source。
- 每支腳本在所有 import 前隔離 `sys.path`，防止系統 site-packages 滲入 venv。

# Rust 執行環境
- 禁止新增 Cargo wrapper script，除非 Cargo 原生 config 無法表達需求。

# GPU 推論
- 硬體為 RTX 4050 6G；AI 推論強制使用 GPU，使用 CPU 即報錯。
- Transformers 使用 `dtype`，不用已棄用的 `torch_dtype`；dtype 必須顯式指定且一致，推論優先對齊訓練 dtype，來源不明預設 BF16；不得隱式混合 dtype。
- 不以降精度替代記憶體或架構設計；優先透過 batch、pipeline、cache 管理 VRAM。
- 推論前確認 GPU state 可重用，且無殘留張量或 cache 干擾。
- 引入中國 AI 平台套件時，確認模型下載源；海外環境指定 HuggingFace，例如 `hub="hf"`。
