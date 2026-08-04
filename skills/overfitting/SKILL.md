---
name: overfitting
description: Manual invocation only
---

- 多時區數據對齊漏洞（Multi-Timeframe Leak）
  - 風險：低週期策略讀到尚未收盤的高週期資料，造成 look-ahead bias。
  - 陷阱：`request.security(sym, "D", close)`
  - 修正：使用已收盤資料，例如 `close[1]`。

- 限價單「觸及即成交」假象（Limit Order Fill Fallacy）
  - 風險：回測以 `Low <= LimitPrice` 視為成交，忽略訂單簿排隊與可成交量。
  - 修正：模擬 queue position、部分成交、成交量限制與延遲。

- 浮點數精度與等值比對失效（Floating-Point Precision Mismatch）
  - 陷阱：`if (CurrentPrice == TargetPrice) ClosePosition();`
  - 修正：使用比較區間或價格 tick，例如 `abs(CurrentPrice - TargetPrice) < 0.0001`。

- 異步狀態機同步失效（Asynchronous State Desynchronization）
  - 風險：下單回報前持倉仍為舊值，補單邏輯重複送單。
  - 陷阱：
    ```python
    SendOrder(Buy, MarketPrice)
    if GetPosition() == 0:
        SendOrder(Buy, MarketPrice)
    ```
  - 修正：以訂單狀態機、client order ID、成交回報與冪等控制管理下單。

- 未來函數（Look-ahead Bias）
  - 定義：當前訊號引用未來資料，例如 `Close[t+1]`、當日完整統計值、會重繪的 ZigZag。
  - 特徵：回測績效異常完美；實盤不可重現。
  - 修正：限制資料只到 `t` 前已確認的資料。

- This Bar／未收盤 K 線訊號
  - 定義：以當前未收盤 K 線的動態 `Close`、`High`、`Low` 產生訊號。
  - 特徵：訊號閃爍（repainting）；回測與實盤不一致。
  - 修正：僅在 K 線收盤觸發，或明確模擬盤中執行。

- 未來函數與 This Bar 差異
  - 未來函數：讀取未來已定格資料；實盤無法取得。
  - This Bar：讀取當前未定格資料；實盤可執行但訊號會變動。

- K 線收盤後執行的風險
  - 風險：execution lag、跳空與滑價。
  - 修正：回測納入延遲、滑價、交易成本與可成交量。

- 曲線擬合／Overfitting
  - 風險：利用已知歷史資料選出最佳參數，樣本外失效。
  - 修正：walk-forward、out-of-sample、交叉驗證與參數穩定性檢查。

- 市場微結構風險
  - 預設：市場為非確定性、分散式且具對抗性的系統。
  - 納入：延遲、部分成交、撤單、滑價、流動性與訂單簿變化。
