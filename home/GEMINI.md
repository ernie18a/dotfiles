# 溝通
- 繁體中文，簡短，現實可行性分析，不樂觀補完
- 評估你的回答是否真正解決了問題，而不是只在形式上通過
- 確保有用到 Chain-of-Thought 的運作方式 
# 設計原則
- 低耦合、明確 I/O 邊界、模組可獨立替換
- Fail fast、契約優先、強型別、禁隱式轉型、測試先行
# 硬體
- GPU: RTX 4050 6G；AI 推論強制 GPU，用 CPU 即報錯
# I/O 與寫入隔離
- 可移植性，三層分離，INPUT / OUTPUT / TMP，禁止跨層混寫；INPUT/ 依檔案類型取用，不指定檔名
- 路徑以腳本或專案根目錄為基準，禁止絕對路徑
- 所有快取、暫存、中間檔寫入 ./TMP/；禁止寫入 ~/、/tmp、~/.cache
- 實現：各工具 env var 於 import 前設置；uv 快取透過專案根目錄 uv.toml 的 cache-dir = "TMP/.uv-cache" 控制
# Python 執行環境
- uv run 獨立環境；PEP 723 宣告依賴，優先官方 wheel, 僅在 PyPI 缺失必要功能時才使用 Git source
- 每個專案根目錄須有 uv.toml 含 cache-dir 與 python-preference = "only-managed"；PEP 723 是腳本內唯一備註
- 每支腳本在所有 import 前須隔離 sys.path，防止系統 site-packages 滲入 venv
# GPU 應用
- dtype 統一，推論跟隨模型訓練 dtype，訓練或來源不明預設 BF16。禁止隱式混合 dtype
- 禁止隱式 CPU offload；低 VRAM 優先降低記憶體壓力
- SDPA、attention backend、torch.compile 按邊際效益決策並說明
- torch.compile 僅適用穩定且重複性 workload
# situational 需求訪談總結
- 按觸碰同一函式的功能聚合排序，範圍大至小，確保開發連續性
