---
name: factor-ind
description: Manual invocation only
---
以 Quant Factor Research 所需的專業知識框架回答問題, 比較 approach 的適用條件與代價, 幾天跟吾比較過後的 approach：
  1. 因子假說與研究設計（Factor Hypotheses & Research Design）

     1.1. Alpha 來源與經濟機制（Alpha Sources & Economic Mechanisms）

     1.1.1. 投資人反應不足、過度反應與處分效應（Investor Under/Overreaction & Disposition Effect）
     1.1.2. 注意力偏誤、群聚效應與動能/反轉機制（Attention Bias, Herding & Momentum/Reversal Mechanisms）
     1.1.3. 流動性供需失衡與微觀價量結構（Liquidity Supply-Demand & Price-Volume Structure）
     1.1.4. 風險溢酬與波動率補償（Risk Premia & Volatility Compensation）

     1.2. 假說規格化與試驗控制（Hypothesis Specification & Experiment Control）

     1.2.1. 可否證假說定義（訊號、持有期、預期方向與經濟邏輯）（Falsifiable Hypothesis: Signal, Horizon, Sign & Logic）
     1.2.2. 適用狀態與明確失效條件（Operating Conditions & Explicit Failure Conditions）
     1.2.3. 事前成功標準與研究停止規則（Ex-Ante Success Criteria & Research Stopping Rules）
     1.2.4. 最小可行實驗與最快反證路徑（Minimum Viable Experiments & Fastest Path to Falsification）
     1.2.5. 試驗帳本與失敗研究歸檔（Experiment Ledger & Failed Research Archiving）

  2. 價量資料工程與標籤構建（OHLCV Data Engineering & Labeling）

     2.1. 資料品質與防偏誤機制（Data Quality & Bias Prevention）

     2.1.1. 生存者偏誤防範與歷史成分管理（Survivorship Bias & Historical Membership）
     2.1.2. 前視偏誤與嚴格時間戳對齊（Look-Ahead Bias & Strict Timestamp Alignment）
     2.1.3. 除權息、拆分割與價格還原調整（Splits, Dividends & Price Adjustments）
     2.1.4. 異常值過濾與缺失值插補政策（Outlier Treatment & Missing Value Policies）
     2.1.5. 資訊驅動採樣（成交量、成交額與 Tick Bar）（Information-Driven Bars: Volume, Dollar & Tick Bars）

     2.2. OHLCV 特徵轉換與高效指標（OHLCV Transformations & Efficient Features）

     2.2.1. 高效波動率估計（Parkinson, Garman-Klass, Yang-Zhang）（Efficient Volatility Estimators）
     2.2.2. K 線幾何特徵與量價動量背離（Bar Geometry & Volume-Price Momentum/Divergence）
     2.2.3. 流動性代理指標（Amihud 非流動性、Corwin-Schultz 價差）（Liquidity Proxies: Amihud & Corwin-Schultz）
     2.2.4. 分數階微分與記憶性平穩特徵（Fractional Differentiation, FFD）
     2.2.5. 訊號平滑與降噪（EMA, Savitzky-Golay, 卡爾曼濾波）（Signal Smoothing & Denoising: Kalman Filtering）

     2.3. 特徵標準化與預測標籤構建（Standardization & Target Labeling）

     2.3.1. 橫斷面與時序標準化（Rank, Robust Z-Score, Winsorization）（Cross-Sectional & Time-Series Standardization）
     2.3.2. 三重大門標籤法（停損、停利與時間大門）（Triple Barrier Method: Stop-Loss, Take-Profit, Time Barrier）
     2.3.3. 波動率調整標籤與樣本權重（Volatility-Adjusted Labels & Sample Weighting）
     2.3.4. 元標籤構建（方向預測與下注信心分離）（Meta-Labeling: Primary Signal & Bet Confidence Separation）

  3. 輕量機器學習與因子挖掘（Lightweight ML & Automated Alpha Discovery）

     3.1. 輕量學習模型（≤6GB GPU）（Lightweight Models ≤6GB GPU）

     3.1.1. 正則化線性模型（Ridge, Lasso, Elastic Net）（Regularized Linear Models）
     3.1.2. 梯度提升樹（LightGBM, XGBoost, CatBoost）（Gradient Boosted Decision Trees）
     3.1.3. 輕量序列與類神經網路（MLP, 輕量 GRU/TCN）（Lightweight Sequence Models: MLP, Compact GRU/TCN）
     3.1.4. 貝葉斯超參數最佳化（Optuna）（Bayesian Optimization & Optuna）

     3.2. 自動化公式因子發現（Automated Formulaic Alpha Discovery）

     3.2.1. 遺傳規劃與符號回歸（PySR, gplearn）（Symbolic Regression & Genetic Programming）
     3.2.2. 語法樹算子庫與公式化因子構造（Operator Syntax Trees & Formulaic Factor Generation）
     3.2.3. 特徵歸因與重要性過濾（SHAP, Tree Gain/Split）（Feature Attribution & SHAP Importance）

  4. 因子驗證、過濾與防過度擬合（Factor Validation, Filtering & Anti-Overfitting）

     4.1. 預測力與統計顯著性檢定（Predictive Power & Statistical Significance）

     4.1.1. 預測力指標（Rank IC, IC Mean, ICIR, Quantile Monotonicity, Long-Short Spread）（Rank IC, ICIR & Monotonicity）
     4.1.2. 訊號衰退與持有期結構（IC Decay Curve & Holding Period Term Structure）
     4.1.3. Newey–West HAC 自相關與異質變異調整檢定（Newey–West HAC Robust Significance）

     4.2. 嚴格時序切片與過度擬合量化（Temporal Validation & Overfitting Defense）

     4.2.1. Purged & Embargoed Walk-Forward 分析（Purged & Embargoed Walk-Forward Analysis）
     4.2.2. 組合淨化交叉驗證（Combinatorial Purged Cross-Validation, CPCV）
     4.2.3. 偽發現率控制（FDR / Benjamini-Hochberg）（False Discovery Rate Control）
     4.2.4. 抗膨脹夏普率與過擬合機率（Deflated Sharpe Ratio DSR & PBO）（Deflated Sharpe Ratio & Probability of Backtest Overfitting）
     4.2.5. 參數鄰域平滑性與 Placebo 隨機排列檢驗（Parameter Surface Smoothness & Placebo Permutation Tests）

     4.3. 增量效用與冗餘因子剔除（Factor Incrementality & Redundancy Filtering）

     4.3.1. 與基準因子相關性矩陣與正交殘差化（Correlation Matrix & Residual Orthogonalization）
     4.3.2. 因子家族聚類去重與增量剔除測試（Factor Clustering Deduplication & Drop-One Testing）

  5. 訊號合成、部位構建與成本控制（Signal Combination, Sizing & Cost Control）

     5.1. 訊號合成與部位配置（Signal Combination & Sizing）

     5.1.1. 輕量聚合（Rank 加權、ICIR 加權、線性/樹模型融合）（Rank/ICIR Weighted Blending & Tree Stacking）
     5.1.2. 訊號衝突處理與部位淨化抵銷（Signal Conflict Resolution & Trade Netting）
     5.1.3. 個人化 Top-N 排名與分位數選股部位（Top-N Ranked & Quantile Long Allocation）
     5.1.4. 單標的部位上限、集中度約束與調倉緩衝區（Position Caps, Concentration Limits & Rebalance Buffers）
     5.1.5. 分數凱利準則與破產風險約束（Fractional Kelly Criterion & Ruin Probability Constraints）

     5.2. 交易摩擦與回測會計（Trading Friction & Backtest Accounting）

     5.2.1. 微資金交易摩擦（手續費、稅、價差、最小跳價與滑價模型）（Commissions, Taxes, Spreads, Tick Size & Slippage）
     5.2.2. 嚴格撮合時序（Bar Close 訊號 vs. Next Bar Open/VWAP 成交）（Strict Execution Sequence: Signal at Close, Fill at Next Open）
     5.2.3. 成本後 Alpha、換手率約束與損益兩平壓力測試（Post-Cost Alpha, Turnover Control & Break-Even Stress Testing）

     5.3. 市場狀態路由與防禦覆蓋（Regime Routing & Defensive Overlay）

     5.3.1. 市場狀態偵測指標（波動率狀態、HMM 狀態、Hurst 指數）（Regime Detection: Volatility, HMM, Hurst）
     5.3.2. 狀態條件權重路由與全局風控停機開關（Conditional Weight Routing & Global Risk-Off Kill Switch）

  6. 個人研究工程與生命週期（Research Engineering & Lifecycle Management）

     6.1. 高效計算與研究可重現性（High-Performance Stack & Reproducibility）

     6.1.1. 高效運算生態（Polars, NumPy, Numba, Parquet）（High-Performance Vectorization & Columnar Storage）
     6.1.2. 決定性計算（隨機種子、環境依賴與 Git/中繼資料版本鎖定）（Deterministic Seeds, Env Pinning & Metadata Tracking）
     6.1.3. 解耦回測管線（資料/特徵/訊號/部位分層與防穿越單元測試）（Decoupled Pipeline Architecture & Leakage Tests）

     6.2. 實盤監控、衰退診斷與因子退役（Live Monitoring, Decay & Retirement）

     6.2.1. Paper Trading 與小資金實盤驗證（Paper Trading & Micro-Capital Live Incubation）
     6.2.2. 即時 IC、換手率與滑價偏離追蹤（Live IC, Turnover & Slippage Drift Tracking）
     6.2.3. 回測與實盤落差歸因（Backtest-to-Live Gap Attribution）
     6.2.4. 因子衰退預警、降權與退役歸檔流程（Factor Decay Warning, Downweighting & Retirement Workflow）
