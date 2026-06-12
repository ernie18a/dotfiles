# SKILL3

## 目的

本技能只給聰明 AI 使用。

聰明 AI 用本技能產生編號計畫書。
笨 AI 不讀本技能。
笨 AI 只讀並執行指定的 `todoNN.md`。

核心目標：

- 降低聰明 AI 實作成本。
- 降低笨 AI 理解成本。
- 降低使用者補下一步成本。
- 保留近似 `follow 00.md` 的無腦操作。

## 使用方式

聰明 AI：

```text
follow SKILL3.md
產生下一份 todoNN.md。
不要執行。
```

笨 AI：

```text
follow todoNN.md
```

`NN` 使用兩位數遞增：

```text
todo01.md
todo02.md
todo03.md
```

一份 `todoNN.md` 是一個 batch。

## 聰明 AI 責任

聰明 AI 負責：

- 讀目前狀態與必要程式碼。
- 決定下一個 batch。
- 產生 `todoNN.md`。
- 把必要規則寫進 `todoNN.md`。
- 判斷上一份 todo 的 unresolved issue。
- 決定直接修，或產生下一份 todo。

聰明 AI 不負責：

- 全程實作。
- 產生長篇背景。
- 把本技能內容原樣塞進 todo。
- 預測所有未發生問題。

## 笨 AI 假設

笨 AI 只知道 `todoNN.md`。

所以 `todoNN.md` 必須自足：

- 要做什麼。
- 可改哪裡。
- 不可改哪裡。
- 測什麼。
- 失敗時怎麼修。
- 何時停止。
- 回報什麼。

不要要求笨 AI：

- 讀 `SKILL3.md`。
- 讀聊天紀錄。
- 自行理解大方向。
- 自行重切 scope。

## todo 大小

一份 todo 依共享上下文切，不依功能數切。

預設限制：

- 最多觸碰 3 個相鄰模組。
- 最多新增或修改 5 個主要檔案。
- 每個功能階段都要有測試。
- 必須能用指定驗證命令判斷結果。

必須縮小：

- 需求不清。
- contract 不穩。
- 涉及資料格式、持久化、併發、權限、外部 I/O。
- 上一份 todo 留下 unresolved issue。

可放寬：

- 變更機械性重複。
- contract 明確。
- 測試覆蓋足夠。

## todo 檔案格式

`todoNN.md` 必須使用下列格式。

```md
# todoNN

## Goal

- 本批完成什麼。

## Scope

Allowed:
- 可改哪些檔案、模組或邊界。

Forbidden:
- 不可碰哪些範圍。
- 不可新增哪些設計。

## Contracts

- input:
- output:
- error:
- invariants:

## Tasks

1. 任務 A
   - change:
   - test:
2. 任務 B
   - change:
   - test:

## Verification

- command:
- expected:

## Failure loop

- 測試失敗後，只修明確局部問題。
- 錯誤變少、位置改變、或通過更多測試，可以繼續修。
- 同一測試、同一錯誤、同一位置重複出現，停止。
- 需要需求、架構、跨模組資料流判斷，停止。
- 同一 todo 最多 4 輪測試修復。

## Report

完成時回報：

- changed files:
- tests:
- result:

停止時回報：

- unresolved issue:
- failed command:
- key error:
- files changed:
- fixes tried:
- current state:
```

## todo 內容規則

todo 要短。

要包含：

- 執行邊界。
- 測試命令。
- 停止條件。
- 回報格式。
- 上一份 todo 遺留 issue，如果有。

不要包含：

- 長背景。
- 聊天紀錄。
- 本技能全文。
- 推測性建議。
- 與本批無關的架構討論。

## Issue 處理

笨 AI 回報 unresolved issue 後，聰明 AI 判斷。

預設：

- 把 issue 放進下一份 `todoNN.md` 的第一個任務。

直接修：

- 問題小。
- 問題局部。
- 修改比再委派更便宜。
- 笨 AI 已卡在同一 issue。

強制直接修：

- 同一 issue 已委派過一次。
- 下一份 todo 仍卡在同一 issue。

禁止：

- 同一 issue 無限產生新 todo。
- 未處理紅測試就開新功能。

## 狀態紀錄

若需要續跑，只維護極短狀態。

格式：

```md
Current:
- todo:
- status: running | done | blocked
- tests:
- unresolved issues:
- next:
```

狀態只用來回答：

- 現在做到哪份 todo。
- 上一份是否完成。
- 下一份要產生什麼。

## 多頭

預設單線。

允許少量多頭：

- 最多 2 份 todo 同時存在。
- scope 必須不重疊。
- 必須有明確合併點。
- 不得增加使用者合併負擔。

不使用多頭：

- contract 不穩。
- 模組邊界不清。
- 測試互相影響。

## 完成判斷

一份 todo 完成需同時滿足：

- scope 內工作完成。
- 指定測試已跑。
- 測試結果符合 expected。
- 無未記錄失敗。
- 回報足夠產生下一份 todo。

若未完成：

- 不補做 scope 外工作。
- 記錄 unresolved issue。
- 回到聰明 AI。
