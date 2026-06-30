---
name: deve
description: 實作、修改或執行程式，建立或調整專案，或處理 Python、Rust、GPU 推論時使用。
---
# 開發規約

- SVG 圓環/撥盤 UI 的渲染與互動模式見 `references/svg-circular-dial.md`（極座標、弧線路徑、旋轉拖曳、刻度標籤、中心分割圓）。

- 只做解決需求的最小變更；不過度設計、不做推測性實作。
- 只輸出新增或修改的部分；修改既有程式碼時，只輸出該函式或區塊，不輸出 boilerplate。
- 優先低耦合與明確 I/O 邊界，讓變動點可局部替換；不為形式過度拆模組。
- 優先 fail fast、明確契約、可驗證型別與顯式轉換；測試優先覆蓋高風險與核心邊界。

# 手稿開發（Handoff-Spec Pattern）

當使用者提供規格文件（如 `oneshot0N.md`、`*NN.md`）時，遵循以下結構化流程：

1. **讀取規格全文** — 理解 Goal、Scope（Allowed/Forbidden）、Phases、Stop conditions、Verification steps。
2. **建立 todo** — 每階段對應一個 todo item，按規格列出的順序排入。
3. **批次實作** — 對同一階段的檔案修改一次完成（獨立修改批次化），減少回合數。
4. **逐階段驗證** — 每完成一個階段標記為 completed，但完整驗證在 Final Verification 階段一次執行。
5. **Final Verification** — 按規格指定的驗證指令執行（`py_compile`、`node --check`、serve + curl 測試、server 停止確認），全部通過後才標記完成。
6. **Close the spec loop** — 更新 spec 本身的 Completed checkpoints 區塊（`[ ]` → `[x]`）與 Report 區塊（filled work、verification、result）。讓 spec 本身成為可審計的執行記錄。

關鍵守則：
- 規格中的 **Forbidden** 區塊是硬約束；列入絕對不做的事。
- **Stop** 區塊列出應中止的條件；若匹配則回報並停止，不強行繼續。
- 規格中的 Verify 表格（方法 + 預期）是 testing oracle，必須逐條滿足。

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
- 輕量靜態前端 + API 專案：在 stdlib `http.server` 上直接加入 GET/POST 路由可避免框架依賴。模式見 `references/stdlib-http-api.md`。
- 每個專案根目錄須有 `uv.toml`，並設定 `python-preference = "only-managed"`。
- 腳本依賴使用 PEP 723 宣告；`requires-python` 設明確上限，以最重依賴的最高支援版本為準；優先官方 wheel，僅在 PyPI 缺失必要功能時使用 Git source。
- 每支腳本在所有 import 前隔離 `sys.path`，防止系統 site-packages 滲入 venv。

## 背景伺服器與埠衝突處理

在開發週期中執行背景 HTTP server 時，常見埠衝突（`[Errno 98] Address already in use`）。

### 原因
前次 server 程序未正確終止，或 TIME_WAIT 狀態下的 socket 尚未釋放。

### 解決方案（依優先順序）

1. **Fuser（首選）**：
   ```
   fuser -k 8000/tcp 2>/dev/null
   sleep 2
   ```
2. **SS + kill**：
   ```
   ss -tlnp | grep 8000
   # 如果看不到 pid，嘗試 pkill
   pkill -f "uv run main.py" 2>/dev/null
   pkill -f "main.py" 2>/dev/null
   ```
3. **備用埠**：若主埠持續被佔用，使用 `--port` 參數切換：
   ```
   uv run main.py --port 8001
   ```
4. **防止殘留**: 使用 SIGINT (`kill -INT <pid>`) 而非 SIGKILL，讓 Python 的 `KeyboardInterrupt` handler 印出 "Stopped." 並正常關閉 socket。

### 確認埠可用
```
ss -tlnp | grep 8000 || echo "free"
```

# Rust 執行環境
- 禁止新增 Cargo wrapper script，除非 Cargo 原生 config 無法表達需求。

# GPU 推論
- 硬體為 RTX 4050 6G；AI 推論強制使用 GPU，使用 CPU 即報錯。
- Transformers 使用 `dtype`，不用已棄用的 `torch_dtype`；dtype 必須顯式指定且一致，推論優先對齊訓練 dtype，來源不明預設 BF16；不得隱式混合 dtype。
- 不以降精度替代記憶體或架構設計；優先透過 batch、pipeline、cache 管理 VRAM。
- 推論前確認 GPU state 可重用，且無殘留張量或 cache 干擾。
- 引入中國 AI 平台套件時，確認模型下載源；海外環境指定 HuggingFace，例如 `hub="hf"`。
