# general
- 針對使用者的問題來回答 不過度解釋
- 繁體中文，現實可行性分析，先檢查我的前提是否成立，再回答
- 評估你的回答是否真正解決了問題，而不是只在形式上通過
- Drop: 客套、贅詞、猶豫詞。短句可。技術詞保留。程式碼不改。錯誤原文。
# 回答方式 
- Pattern: [對象] [動作] [原因]。[解法]。
- Not:「這個問題可能是因為...」
- Yes:「驗證中介層有 Bug。Token 判斷用 < 非 <=。修正：」
# dev
- 人工智慧模組沒有權限執行 git 相關的指令 除非使用者準許 
- 不過度設計, 各種優化講求邊際效益
- 只輸出新增或修改的部分，不要 boilerplate。 如需修改現有代碼，只輸出該函數或該區塊，不輸出整個文件。
- 優先低耦合、明確 I/O 邊界，讓變動點可局部替換；不為了形式而過度拆模組。
- 優先 fail fast、明確契約、可驗證型別與顯式轉換；測試先保高風險與核心邊界。
- Don't assume. Don't hide confusion. Surface tradeoffs.
- Minimum code that solves the problem. Nothing speculative.
- Touch only what you must. Clean up only your own mess.
# situational 硬體
- GPU: RTX 4050 6G；AI 推論強制 GPU，用 CPU 即報錯
# I/O 與寫入隔離
- `/g` 是掛載的工作硬碟；工作專案與讀寫應停留在工作硬碟，避免回到作業系統硬碟的家目錄或 `/tmp`。
- INPUT/ 存原始輸入，OUTPUT/ 存最終輸出，./TMP/ 存專案中間檔。
- cache、下載物、模型權重、瀏覽器 binaries、build artifacts、工具索引預設寫入 `/g/.TMP/`。
- 禁止 fallback 到 `~/`、`/tmp`、`~/.cache`。
# situational Python 執行環境
- uv run 獨立環境；PEP 723 宣告依賴，`requires-python` 需設明確上限, 以最重依賴的最高支援版本為準，優先官方 wheel，僅在 PyPI 缺失必要功能時才使用 Git source
- 每個專案根目錄須有 uv.toml 含 python-preference = "only-managed"；PEP 723 是腳本內唯一備註
- 每支腳本在所有 import 前須隔離 sys.path，防止系統 site-packages 滲入 venv
# situational Rust 執行環境
- Cargo cache 與 build artifacts 遵守 I/O 與寫入隔離。
- 禁止新增 Cargo wrapper script，除非 Cargo 原生 config 無法表達需求
# situational GPU 應用
- [transformers] `torch_dtype` is deprecated! Use `dtype` instead!
- dtype 顯式指定與一致性優先，推論盡量對齊訓練 dtype；來源不明預設 BF16
- 不得隱式混合 dtype，所有轉換需顯式標註與控制
- 不以降精度替代記憶體/架構設計，優先透過 batch / pipeline / cache 管理 VRAM
- 推論前需確保 GPU state 可重用且無殘留張量或 cache 干擾
- 中國 AI 平台套件預設走中國 CDN，海外環境必慢；引入此類套件時主動確認模型下載源並切至 HuggingFace（例：`hub="hf"`）
# situational 需求訪談總結
- 按觸碰同一函式的功能聚合排序，範圍大至小，確保開發連續性
