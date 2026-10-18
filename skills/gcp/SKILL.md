---
name: gcp
description: Manual invocation only
---

- 使用者未指定主機時討論對象為雲端 VM `gcp` tmux session，遠端指令以 `ssh -F ~/.ssh/gcp_config gcp '<指令>'` 執行
- 使用者提到 `papa` 時改為 `192.168.213.199`，遠端指令以 `ssh 192.168.213.199 '<指令>'` 執行
- 使用者指定 IP 時改為該 IP 主機，遠端指令以 `ssh <IP> '<指令>'` 執行
- 討論對象不是本地端或當下目錄。
- VM 沒有 GitHub 金鑰。VM 端的 git 操作先以 `eval "$(ssh-agent -s)"; ssh-add ~/.ssh/id_ed25519 </dev/null` 載入金鑰，再用 `ssh -A -F ~/.ssh/gcp_config gcp '<指令>'` 執行。
- VM 記憶體約 1GB 且常駐爬蟲，不在 VM 上執行 高記憶體工作。
- 本地與 VM 的 `/g` 刻意保持一致。日誌等執行期產物從 VM 讀取，程式碼一律讀本地 `/g` 的同路徑檔案以求快速。
- 要觀察運作結果或是日志時, 參考云端環境, 要參考代碼邏輯時, 參考 localhost 相同的絕對路徑 會比較快 .
- 修改程式碼時在本地 `/g/*/` 修改，經 git push 後在 VM 端 `git pull` 
