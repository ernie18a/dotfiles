#!/usr/bin/env bash
set -euo pipefail
exec ssh -F ~/.ssh/gcp_config -o ConnectTimeout=10 -o BatchMode=yes gcp 'bash -s' <<'REMOTE'
set -euo pipefail
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_command} #{pane_pid}' | while read -r p c pid; do
  if c=$(ps --ppid "$pid" -o pid= | head -1 | tr -d ' ') && [ -n "$c" ]; then
    d=$(readlink /proc/$c/cwd)
    f=$(tail -z -n +2 /proc/$c/cmdline | while IFS= read -r -d '' a; do [[ $a = /* ]] || a=$d/$a; [ -f "$a" ] && { realpath "$a"; break; }; done || true)
    s="RUN:$f"
  else s=IDLE; fi
  printf '\n\033[1;33m┌─ %s [%s]\033[0m\n' "$p" "$s"
  { tmux capture-pane -p -e -t "$p" | grep -v -P '^(\s|\e\[[0-9;]*m)*$' || true; } | tail -n 3 | sed $'s/^/\e[1;33m│\e[0m /'
  printf '\033[1;33m└─\033[0m\n'
done
REMOTE
