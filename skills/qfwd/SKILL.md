---
name: qfwd
description: >
  Use this skill whenever the user wants to decompose, reverse-engineer, or enumerate
  sub-directions under the seven quantitative/algorithmic trading major frameworks:
  Change Point Detection, Regime Detection, GEX/Options Structure, Vectorized Backtesting,
  Matrix Profile / Shape Pattern Mining, Portfolio / Risk Layer, and
  Cross-sectional / Tree-based / Feature Learning.
  Trigger when the user asks "what are the sub-items of X", "break down X into smaller pieces",
  "list what falls under X", "what does X include", or any variation of decomposing
  a major analytical framework into concrete implementable components.
  Also trigger when the user provides a list of high-level quant/ML topics and asks
  to find what belongs under them.
---

# Quant Framework Decomposition Skill

## Purpose

This skill guides an AI to **reverse-engineer** each major quantitative research
framework into its concrete, implementable sub-directions. The output is not a
vague outline — it is a **flat, actionable list** of techniques, algorithms, and
deliverables that belong under each parent framework.

---

## Decomposition Rules

When decomposing a major direction, apply these rules:

1. **Algorithms first** — list the specific algorithm or method, not the general concept.
   - Bad: "detect breakpoints in time series"
   - Good: "PELT (Pruned Exact Linear Time) for offline change point detection"

2. **One level deeper than obvious** — the first layer is usually too abstract.
   The sub-direction should be specific enough that a developer can immediately
   choose a library or write a function.

3. **Include both statistical and engineering sub-items** — every major direction has
   a math component AND an implementation / data pipeline component.
   Both are sub-directions.

4. **Flag cross-module dependencies explicitly** — if a sub-direction is also
   a *feeder* into another major framework, note it with `[→ feeds: <parent>]`.

5. **Keep GEX / Options Structure as a sub-item of Regime Detection** —
   it is not a standalone framework. Its outputs are *features*, not methods.

---

## The Seven Major Frameworks and Their Decomposition Space

### 1. Change Point Detection
Parent scope: detect where the statistical properties of a time series shift.

Sub-directions to enumerate:
- Offline methods (full series known): PELT, Binary Segmentation, BOCPD offline variant, `ruptures` library
- Online methods (streaming): Bayesian Online Change Point Detection (Adams & MacKay), CUSUM, Page-Hinkley test
- Multivariate change point: joint detection across multiple series (e.g., price + volume + vol)
- Change point typing: mean shift vs. variance shift vs. autocorrelation structure shift
- Penalty / cost function selection: L1, L2, RBF kernel, Mahalanobis
- Post-detection validation: minimum segment length, false positive rate control
- Integration layer: feeding detected change points as binary features into Regime Detection `[→ feeds: Regime Detection]`
- Macro time series variant: applying CPD to economic series (yield curve, PMI, CPI) `[→ feeds: Regime Detection]`

---

### 2. Regime Detection
Parent scope: define a small number of stable, repeating market states from multi-source features.

Sub-directions to enumerate:
- Hidden Markov Models (HMM): Gaussian emission, number-of-states selection via BIC/AIC, Viterbi decoding
- Bayesian HMM: sticky HDP-HMM for variable-length regimes, online posterior update
- Gaussian Mixture Models (GMM): EM-based clustering in feature space, covariance type selection
- Clustering-based regime: k-means / k-medoids on rolling feature windows; cluster stability via silhouette
- Feature engineering for regime input:
  - Realized volatility (5-min, 1-day, rolling window)
  - Return autocorrelation / Hurst exponent
  - Options-derived features: IV term structure slope, skew, GEX `[← from: GEX sub-system]`
  - Macro factor loadings: PCA on yield curve, PMI, credit spreads
- Regime label stability: out-of-sample persistence, regime confusion matrix
- Regime transition matrix: estimating switching probabilities for forward-looking use
- Regime-conditioned signal gating: using regime label as filter before Backtesting `[→ feeds: Backtesting]`

---

### 3. GEX / Options Structure  ← Sub-system (feeds into Regime Detection and Backtesting)

> **Note:** This is NOT a standalone major framework. It is a data source and feature
> generator. Its outputs become inputs to Regime Detection and Backtesting filters.

Sub-directions to enumerate:
- GEX calculation: per-strike gamma × OI × 100 × spot², aggregated across all strikes
- GEX flip point: net dealer gamma sign change price level (zero-crossing)
- Gamma wall identification: strike clusters with highest absolute GEX concentration
- IV surface construction: interpolation across strike / expiry grid (SVI parametrization, SSVI)
- Term structure features: front-month vs. back-month IV ratio, contango / backwardation
- Skew features: 25-delta risk reversal, 10-delta put/call skew asymmetry
- Put/Call OI ratio and its rolling change
- Dealer net delta exposure estimation from aggregate OI and delta
- Intraday GEX update: re-computing as spot price moves (delta-adjusted gamma shift)
- Dashboard layer: real-time visualization of gamma profile, flip point, IV surface `[deliverable: Dashboard]`
- Feature export: structured output → feature vector `[→ feeds: Regime Detection, Backtesting]`

---

### 4. Vectorized Backtesting / Strategy Scanning
Parent scope: verify the economic value of signals using price, cost, and statistical rigor.

Sub-directions to enumerate:
- Signal-to-position mapping: threshold, z-score, quantile-based entry logic
- Vectorized engine design: NumPy / Pandas position matrix, avoiding look-ahead bias
- Transaction cost modeling: fixed spread, proportional commission, market impact (Almgren-Chriss lite)
- Walk-forward validation: expanding window, rolling window, anchored split
- Combinatorial Purged Cross-Validation (CPCV): De Prado method for financial CV
- Performance metrics: Sharpe, Calmar, max drawdown, profit factor, hit rate, expectancy
- Multiple testing correction: Bonferroni, BHY procedure, deflated Sharpe ratio
- Regime-conditioned backtesting: separate performance attribution per detected regime `[← from: Regime Detection]`
- Parameter sensitivity / robustness surface: 2D heatmap of Sharpe over parameter grid
- Strategy scanning pipeline: batch evaluation of N signals × M parameter sets

---

### 5. Matrix Profile / Shape Pattern Mining
Parent scope: find statistically recurring shape motifs in long time series without look-ahead bias.

Sub-directions to enumerate:
- Matrix Profile computation: STOMP algorithm, SCRIMP++ (anytime approximate), GPU variants
- Subsequence length selection: domain heuristics vs. significance testing
- Motif discovery: top-K motifs, motif neighbor radius definition
- Discord detection: anomaly subsequences (anti-motifs)
- Semantic segmentation via Matrix Profile: domain-agnostic regime boundary detection `[→ feeds: Regime Detection]`
- Motif post-analysis: forward return distribution per motif cluster (mean, std, skew)
- Motif labeling and clustering: k-Shape clustering, DTW barycenter averaging
- Shape feature extraction: slope, curvature, relative amplitude, retracement ratio
- Multi-dimensional Matrix Profile (mSTOMP): joint pattern across price, volume, vol
- Minimum description length (MDL) for motif count selection: avoiding over-segmentation
- Candidate pattern → backtest pipeline: each motif cluster feeds Backtesting `[→ feeds: Backtesting]`

---

### 6. Portfolio / Risk Layer
Parent scope: allocate across validated signals, control exposure and drawdown.

Sub-directions to enumerate:
- Position sizing: fixed fractional, Kelly (full and fractional), vol-targeted sizing
- Hierarchical Risk Parity (HRP): Marcos Lopez de Prado method, linkage sensitivity
- Mean-Variance Optimization: covariance estimation (Ledoit-Wolf shrinkage, OAS, MCD robust)
- Black-Litterman: combining prior equilibrium with signal-derived views
- Correlation regime adjustment: using Regime label to switch covariance matrix `[← from: Regime Detection]`
- Factor exposure control: neutralizing beta, sector, or macro factor exposure
- Drawdown control: equity curve monitoring, max drawdown circuit breaker, vol scaling
- Liquidity constraint: capacity estimation per signal, turnover limit
- Tail risk: CVaR optimization, stress testing vs. historical crisis periods
- Multi-signal aggregation: ensemble weighting, signal orthogonality check before combining

---

### 7. Cross-sectional / Tree-based / Feature Learning
Parent scope: use ML across multiple instruments or feature sets — only when baseline methods show clear evidence of incremental gain.

Sub-directions to enumerate:
- Cross-sectional momentum / reversal: rank-based signal construction, industry-neutralization
- Feature importance baseline: SHAP values on gradient-boosted models (XGBoost, LightGBM)
- Purged cross-validation for ML: embargo period, combinatorial splits `[← from: Backtesting methodology]`
- Tree-based regime classifier: using labeled regimes as targets `[← from: Regime Detection]`
- Feature selection: Recursive Feature Elimination with CV, Boruta, mRMR
- Time series feature extraction: tsfresh, catch22 — automated feature generation
- Representation learning: autoencoders for latent market state embedding `[→ feeds: Regime Detection]`
- Ensemble stacking: level-1 signal scores → level-2 meta-learner
- Online learning: Vowpal Wabbit, river — for non-stationary feature drift
- Incremental gain test: only adopt if Sharpe improvement over baseline survives CPCV `[gate: Backtesting]`

---

## Output Format When Using This Skill

When a user asks to decompose one or more frameworks, output:

```
## [Framework Name]

**Role:** [standalone method | sub-system | feature generator | validation layer]
**Feeds into:** [list of other frameworks this outputs to, if any]
**Receives from:** [list of other frameworks that feed this, if any]

### Sub-directions:
1. [Specific algorithm / technique / deliverable]
2. ...
```

Do not summarize. Do not group into vague categories. List every specific item flat.
If implementation libraries are well-known for a sub-direction, name them inline.

---

## Triggering Examples

- "Change Point Detection 底下有哪些小方向？"
- "幫我列出 Regime Detection 的子項目"
- "Matrix Profile 包含哪些具體技術？"
- "把這七個大方向的子項目全部列出來"
- "GEX 底下有哪些我可以實作的東西？"
- "這些框架各自有哪些可以實際寫代碼的子模塊？"
