#!/usr/bin/env bash
# 用法：u.oom.sh kill_top|kill_cc [user@host]   本機執行，遠端不互動
#       u.oom.sh install                       在 VM 上以 root 執行
H=${2:-e@8.235.107.113}
SSH=(ssh -T -i ~/.ssh/id_ed25519 -o ConnectTimeout=600 -o ServerAliveInterval=15 -o ServerAliveCountMax=60 "$H")

# 殺掉 RSS 最大的程序（排除 sshd/systemd）
kill_top() { "${SSH[@]}" 'ps -eo pid=,rss=,comm= --sort=-rss | awk '\''$3 !~ /^(sshd|systemd)/ {print; system("sudo kill -9 " $1); exit}'\''; free -m'; }

# 殺掉所有 codex 與 claude
kill_cc() { "${SSH[@]}" 'sudo pkill -9 -f "[c]odex|[c]laude"; free -m'; }

# 記憶體不足時直接殺最大程序，不進入 thrashing
install() {
  set -euo pipefail
  cat > /etc/tmpfiles.d/mglru-anti-thrash.conf <<'CONF'
w /sys/kernel/mm/lru_gen/enabled - - - - y
w /sys/kernel/mm/lru_gen/min_ttl_ms - - - - 1000
CONF
  systemd-tmpfiles --create /etc/tmpfiles.d/mglru-anti-thrash.conf
  apt-get update -qq
  apt-get install -y -qq earlyoom
  cat > /etc/default/earlyoom <<'CONF'
EARLYOOM_ARGS="-m 15,8 -s 100,100 -r 3600 --avoid '^(sshd|systemd|systemd-.*|google_.*|earlyoom)$'"
CONF
  systemctl enable --now earlyoom
  echo 'kernel.sysrq = 1' > /etc/sysctl.d/90-sysrq.conf
  sysctl -q --system
}

"$1"
