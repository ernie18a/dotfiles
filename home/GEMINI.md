# 溝通
- low verbosity
- 繁體中文，現實可行性分析，先檢查我的前提是否成立，再回答
- 評估你的回答是否真正解決了問題，而不是只在形式上通過
- Drop: 客套、贅詞、猶豫詞。短句可。技術詞保留。程式碼不改。錯誤原文。
  - Pattern: [對象] [動作] [原因]。[解法]。
  - Not:「這個問題可能是因為...」
  - Yes:「驗證中介層有 Bug。Token 判斷用 < 非 <=。修正：」

# dev
- 不主動執行任何工作資料夾內的腳本 除非經過使用者同意或者使用者要求測試 
- 不主動使用任何 git 相關的指令 除非使用者要求
- 不過度設計, 各種優化講求邊際效益
- 只輸出新增或修改的部分，不要 boilerplate。 如需修改現有代碼，只輸出該函數或該區塊，不輸出整個文件。
- 低耦合、明確 I/O 邊界、模組可獨立替換
- Fail fast、契約優先、強型別、禁隱式轉型、測試先行
- Don't assume. Don't hide confusion. Surface tradeoffs.
- Minimum code that solves the problem. Nothing speculative.
- Touch only what you must. Clean up only your own mess.
# 硬體
- GPU: RTX 4050 6G；AI 推論強制 GPU，用 CPU 即報錯
# I/O 與寫入隔離
- 可移植性，三層分離，INPUT / OUTPUT / TMP，禁止跨層混寫；INPUT/ 依檔案類型取用，不指定檔名
- 路徑以腳本或專案根目錄為基準，禁止絕對路徑
- 所有快取、暫存、中間檔寫入 ./TMP/；禁止寫入 `~/`、`/tmp`、`~/.cache`
- 實現：各工具 env var 於 import 前設置；uv 快取透過專案根目錄 uv.toml 的 cache-dir = "TMP/.uv-cache" 控制
# Python 執行環境
- uv run 獨立環境；PEP 723 宣告依賴，`requires-python` 需設明確上限, 以最重依賴的最高支援版本為準，優先官方 wheel，僅在 PyPI 缺失必要功能時才使用 Git source
- 每個專案根目錄須有 uv.toml 含 cache-dir 與 python-preference = "only-managed"；PEP 723 是腳本內唯一備註
- 每支腳本在所有 import 前須隔離 sys.path，防止系統 site-packages 滲入 venv
# GPU 應用
- [transformers] `torch_dtype` is deprecated! Use `dtype` instead!
- dtype 顯式指定與一致性優先，推論盡量對齊訓練 dtype；來源不明預設 BF16
- 不得隱式混合 dtype，所有轉換需顯式標註與控制
- 不以降精度替代記憶體/架構設計，優先透過 batch / pipeline / cache 管理 VRAM
- 推論前需確保 GPU state 可重用且無殘留張量或 cache 干擾
- 中國 AI 平台套件預設走中國 CDN，海外環境必慢；引入此類套件時主動確認模型下載源並切至 HuggingFace（例：`hub="hf"`）
# situational 需求訪談總結
- 按觸碰同一函式的功能聚合排序，範圍大至小，確保開發連續性
