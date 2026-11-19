---
name: gcp2
description: Manual invocation only
disable-model-invocation: true
---

- 第一個參數指定針對的對象，查看、討論、修改皆以該對象為準，未給參數時為 `gcp`。對象不是本地端或當下目錄。
  - `gcp`：雲端 VM tmux session，以 `ssh -F ~/.ssh/gcp_config gcp '<指令>'` 存取
  - `papa`：主機 `192.168.213.199`，以 `ssh 192.168.213.199 '<指令>'` 存取
  - IP：該 IP 主機，以 `ssh <IP> '<指令>'` 存取
  - `r2`：Cloudflare R2 bucket，連線設定在 `/g/tools/colab/DATA/confs.toml`，以 `/g/tools/colab/DATA/r2.py` 存取

# 對象為 `gcp` 時
- VM 記憶體約 1GB 且常駐爬蟲，不在 VM 上執行高記憶體工作。
- 本地 `/g` 與 VM 有同一套程式碼。閱讀與修改程式碼在本地同路徑進行以節省 token，日誌、輸出與暫存檔等執行期產物從 VM 讀取。
- 未給參數時，先執行下列檢查，再以每個 pane 一行回報使用者、執行腳本的絕對路徑、執行中或已完成。
- 腳本絕對路徑由 pane 路徑與指令中的腳本名稱組成。
- pane 有子程序時為執行中，腳本取自子程序指令。pane 無子程序時為已完成，腳本取自末個提示列指令。
- 檢查指令：`ssh -F ~/.ssh/gcp_config gcp 'for u in e o n; do T="sudo -n -u $u tmux"; $T ls >/dev/null 2>&1 || continue; for t in $($T list-panes -a -F "#{session_name}:#{window_index}.#{pane_index}"); do echo "=== $u $($T display -p -t $t "#{pane_current_path}")"; ps --ppid $($T display -p -t $t "#{pane_pid}") -o args --no-headers; $T capture-pane -p -t $t | grep "\$ " | tail -1; done; done'`

# Situational
- 使用者另有 Google Colab，以本地 `colab` CLI 存取。
