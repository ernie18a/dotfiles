---
name: pic
description: Manual invocation only
disable-model-invocation: true
---

- 將 `/mnt/c/Users/e/Pictures/Screenshots` 的圖片依修改時間由新到舊排序。
- 未指定圖片時，以最新一張為起點往舊逐張判斷是否與起點同一系列，遇到第一張不同系列即停，起點到停止前的圖片即為所選圖片。
- 參數為單獨數字 N 時，只選排序後第 N 張。使用者明說「前 N 張」這類範圍時，選取該範圍。
- 按使用者附帶的描述讀取並分析所選圖片，回覆先列出所選圖片。
