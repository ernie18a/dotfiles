---
name: overfitting
description: Manual invocation only
---

# 避免過度擬合與不實回測

- 只使用決策當下已知且已確認的資料；不得使用 `Close[t+1]`、尚未公布的完整統計值、事後定格的重繪指標、未收盤 K 線或未收盤的高週期資料。對齊盤中訊號、收盤後條件與實際可成交時點。
- 不得看過 out-of-sample 或測試集後繼續修改策略。限制模型自由度相對於有效樣本量。
