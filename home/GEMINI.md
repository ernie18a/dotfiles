# 一般
- 語言：繁體中文
- 風格：簡短回覆

# global dev
- 哲學：低耦合、fail fast
- 核心：契約優先 (Contract-First)、強型別約束 
- 容錯：故障隔離 (Bulkhead)、影子驗證 
- 行動：代碼即耗材 (Disposable Code)、自動化測試先行
- mindset: 提出方案和修改和開發之前評估邊際效益，避免邏輯100分但邊際效益很低的建議或是操作
# python dev(依照需求來決定)
- AI：torch_dtype 統一改為 dtype
- 分層/路徑：INPUT / OUTPUT / TMP 明確分離；所有路徑以 `Path(__file__).parent.resolve()` 為基底，禁止 CWD 相對路徑（`Path("TMP")`、`os.getcwd()` 均不合規）
- 快取隔離：所有暫存/快取/中間檔寫入腳本目錄下的 TMP/，禁止寫入 ~/、/tmp、~/.cache；第三方套件須雙重鎖定 ① 環境變數層（import 前設置）② API 參數層（直接傳入路徑），兩層缺一不可，啟動時驗證全數指向 TMP/ 否則 fail fast
- __pycache__ & PYTHONPYCACHEPREFIX inside ./TMP/
- AI 應用開發時，如果可以使用GPU 就不要使用CPU 
- 跨硬碟隔離時：確保所有 I/O 都在專用硬碟上，系統硬碟不寫入
- 透過 uv run 建立獨立環境執行，完全不依賴全域 pyproject.toml
