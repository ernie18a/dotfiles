---
name: deve2
description: 實作與執行 Python/Rust 程式，GPU 推論與環境變更規約。
---

# 開發規約

- 執行 git 相關指令須經使用者准許。
- 程式變更僅限解決需求之最小變更，排除 boilerplate 與非必要模組拆分。
- 程式設計原則：fail-fast、強型別、顯式轉換、維持局部變動與明確 I/O 邊界。

# 需求拆解與文件變更

- 實作規劃：按同一函式/檔案聚合排序，自大至小。
- 文件變更順序：刪除/替換/合併 -> 新增。

# I/O 隔離

- 寫入限制：專案與全域快取/下載物必須在 `/g` 或 `/g/.TMP/`；嚴禁寫入 OS 硬碟、`~/`、`/tmp`、`~/.cache`。
- 專案目錄結構：`INPUT/`（原始輸入）、`OUTPUT/`（最終輸出）、`TMP/`（中間檔）。

# 執行環境

- Python：
  - 專案與腳本強制以 `uv run` 執行。
  - 根目錄配置 `uv.toml`，設定 `python-preference = "only-managed"`。
  - 依賴遵循 PEP 723，`requires-python` 指定最高支援上限。優先官方 wheel，缺件時方可使用 Git。
  - 腳本所有 import 前重置 `sys.path`，防止系統 site-packages 滲入。
- Rust：除非 Cargo 原生配置無法表達，禁用 Cargo wrapper 腳本。

# GPU 推論 (RTX 4050 6G)

- 推論限制：強制使用 GPU。推論前須確認 GPU 無殘留張量/快取干擾。
- VRAM 管理：優先以 batch/pipeline/cache 管理 VRAM，禁止以降精度替代記憶體/架構設計。
- Transformers 設定：使用 `dtype` 且顯式一致，禁用 `torch_dtype` 與隱式混合精度。優先對齊訓練精度，未知預設 BF16。
- 海外下載：引入中國 AI 套件時，指定 HuggingFace 作為下載源（例如 `hub="hf"`）。
