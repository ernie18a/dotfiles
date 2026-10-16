---
name: gcp
description: Manual invocation only
---

- 討論對象是雲端 VM `gcp`，不是本地端或當下目錄。提到的 `/g/*/` 路徑一律指雲端。
- 遠端指令一律以 `ssh -F ~/.ssh/gcp_config gcp '<指令>'` 執行。每次連線獨立，需要工作目錄時在指令前加 `cd <路徑> &&`。
- VM 沒有 GitHub 金鑰。VM 端的 git 操作先以 `eval "$(ssh-agent -s)"; ssh-add ~/.ssh/id_ed25519 </dev/null` 載入金鑰，再用 `ssh -A -F ~/.ssh/gcp_config gcp '<指令>'` 執行。
- VM 記憶體約 1GB 且常駐爬蟲，不在 VM 上執行 高記憶體工作。
- 修改程式碼時在本地 `/g` 修改，經 git push 後在 VM 端 `git pull` 
