---
name: rg
description: Manual invocation only
disable-model-invocation: true
---

未指定範圍時，只處理 `/g/data/tv26101718708/.read3/` 底下的檔案。

- 別名一律英文，是同一概念在該領域實際通用的稱呼，包含同義詞、縮寫與詞形變化，不收會造成誤會的詞。
- 產生別名前不讀取搜索範圍內的檔案與檔名。
- 一律用 `rg`，固定字串、不分大小寫、不使用 `--hidden`，篩選檔名時以 `-l` 納入、以 `--files-without-match` 排除。
- 候選檔案過多時，抽看命中行與前後文辨識雜訊或目標共現字串，反覆在現有候選集調整納入與排除條件，直到剩餘檔數可直接全量判讀。
