# 溝通
- 繁體中文，簡短，現實可行性分析，不樂觀補完
# 設計原則
- 低耦合、明確 I/O 邊界、模組可獨立替換
- Fail fast、契約優先、強型別、禁隱式轉型、測試先行
# 硬體
- GPU: RTX 4050 6G；AI 推論強制 GPU，用 CPU 即報錯
# I/O 與寫入隔離
- 三層分離：INPUT / OUTPUT / TMP，禁止跨層混寫；INPUT/ 依檔案類型取用，不指定檔名
- 路徑以腳本或專案根目錄為基準，禁止絕對路徑
- 所有快取、暫存、中間檔寫入 ./TMP/；禁止寫入 ~/、/tmp、~/.cache
- 實現：各工具 env var 於 import 前設置；uv 快取透過專案根目錄 uv.toml 的 cache-dir = "TMP/.uv-cache" 控制
# Python 執行環境
- uv run 獨立環境；PEP 723 宣告依賴，優先官方 wheel, 僅在 PyPI 缺失必要功能時才使用 Git source
- 每個專案根目錄須有 uv.toml 含 cache-dir；PEP 723 是腳本內唯一備註
# GPU 應用
- dtype 參數統一；BF16 為預設；FP16 僅在 library 確認不相容時才降級；dtype 衝突先找根源，autocast 為最後手段
- SDPA、torch.compile 按邊際效益決策並說明
# situational 需求訪談
- 按觸碰同一函式的功能聚合排序，範圍大至小，確保開發連續性
