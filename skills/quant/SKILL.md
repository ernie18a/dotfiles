---
name: quant
description: Manual invocation only
---

# Quant Factor Research

將以下條目作為回答時具備的量化因子研究知識與 mindset，依問題選用並比較相關方法的適用條件與代價；它們不是固定工作流程，也不必逐項輸出。

## 1. 因子假說與研究設計

- 解釋 Alpha 的經濟機制：投資人反應不足或過度、處分效應、注意力偏誤、群聚、動能或反轉、流動性供需與價量微觀結構、風險溢酬與波動率補償。
- 建立可否證假說，明定訊號、持有期、預期方向、經濟邏輯、適用狀態與失效條件。
- 事前設定成功標準與停止規則；以最小可行實驗尋找最快反證路徑，並保留試驗帳本及失敗研究。

## 2. OHLCV 資料工程與標籤

- 控制存活者與前視偏誤，管理歷史成分、嚴格對齊時間戳，處理除權息、拆分、還原、異常值與缺失值；按需要使用成交量、成交額或 Tick Bar 等資訊驅動採樣。
- 評估 K 線幾何、量價動量與背離、Parkinson／Garman-Klass／Yang-Zhang 波動率、Amihud 非流動性、Corwin-Schultz 價差、分數階微分，以及 EMA、Savitzky-Golay 或卡爾曼濾波等平滑降噪方法。
- 依橫斷面或時序採用 Rank、Robust Z-Score、Winsorization；建立三重障礙、波動率調整標籤、樣本權重或元標籤。

## 3. 輕量模型與自動因子發現

- 在不超過 6GB GPU 的條件下，考慮 Ridge、Lasso、Elastic Net、LightGBM、XGBoost、CatBoost、MLP、輕量 GRU／TCN，並可用 Optuna 最佳化超參數。
- 以 PySR、gplearn、遺傳規劃、符號回歸或語法樹算子庫探索公式因子，再用 SHAP 或樹模型 gain／split 過濾特徵。

## 4. 驗證、過濾與防過度擬合

- 衡量 Rank IC、IC mean、ICIR、分位單調性、多空價差、IC 衰退與持有期結構，並以 Newey–West HAC 修正自相關與異質變異。
- 使用 purged and embargoed walk-forward 或 CPCV；用 FDR／Benjamini-Hochberg、Deflated Sharpe Ratio、PBO、參數面平滑性及 placebo permutation 控制多重嘗試與過度擬合。
- 以相關矩陣、正交殘差化、因子家族聚類與 drop-one test 檢驗增量效用並剔除冗餘。

## 5. 訊號、部位與成本

- 比較 Rank 或 ICIR 加權、線性或樹模型融合；處理訊號衝突與交易淨額，支援個人化 Top-N 或分位數選股。
- 設定單一標的上限、集中度、調倉緩衝、分數 Kelly 與破產風險約束。
- 以波動率、HMM 或 Hurst 等方法偵測市場狀態，按狀態路由權重並設定全局 risk-off 停機開關。

## 6. 研究工程與生命週期

- 使用 Polars、NumPy、Numba、Parquet 等高效工具；固定隨機種子、環境依賴及 Git／中繼資料版本，確保決定性與可重現性。
- 解耦資料、特徵、訊號與部位層，加入防資料穿越測試。
- 以 paper trading 與小資金實盤驗證；追蹤即時 IC、換手率與滑價偏離，歸因回測與實盤差距，並對衰退因子預警、降權、退役及歸檔。
