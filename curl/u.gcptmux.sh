#!/usr/bin/env bash
set -euo pipefail
exec ssh -F ~/.ssh/gcp_config -o ConnectTimeout=10 -o BatchMode=yes gcp 'sudo -n bash -s' <<'REMOTE'
f() { local d=$1 a; shift; for a; do [[ $a = /* ]] || a=$d/$a; [ -f "$a" ] && { realpath "$a"; return; }; done; echo -; }
for k in /tmp/tmux-*/default; do
  u=$(stat -c %U "$k")
  tmux -S "$k" list-panes -a -F '#{pane_pid}	#{pane_current_path}	#{@rc}	#{@cmd}' 2>/dev/null | while IFS=$'\t' read -r pid d rc cmd; do
    c=$(ps --ppid "$pid" -o pid= | head -1 | tr -d ' ')
    if [ -n "$c" ]; then
      mapfile -d '' a < <(tail -z -n +2 /proc/$c/cmdline)
      p=$(f "$(readlink /proc/$c/cwd)" "${a[@]}"); s=RUN
    else
      read -ra a <<< "$cmd"
      p=$(f "$d" "${a[@]}")
      case $rc in '') s=- ;; 0) s=OK ;; *) s=ERR ;; esac
    fi
    echo "$u $p $s"
  done
done
REMOTE
