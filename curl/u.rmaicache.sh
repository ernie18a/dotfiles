#!/usr/bin/env bash
# 刪除 e、o、n 三個使用者下列指定的紀錄與快取，其餘一律保留
sudo bash <<'EOF'
shopt -s extglob
for h in /home/{e,o,n}; do
  r=$h/.codex/packages/app-server-daemon
  c=$(readlink -e "$r/current")
  rm -rf "$r"/releases/!(${c##*/})
  rm -rf "$h"/.codex/{*.sqlite*,.sqlite-maintenance.lock,models_cache.json,tmp,.tmp,cache,sessions,session_index.jsonl,shell_snapshots,history.jsonl,log,thread-writer-locks,tui-thread-reference-capabilities}
  rm -rf "$h"/.claude/{.last-cleanup,.last-update-result.json,backups,cache,file-history,history.jsonl,projects,session-env,shell-snapshots}
  rm -rf "$h"/.gemini/tmp
  rm -rf "$h"/.gemini/antigravity-cli/{annotations,brain,cli.log,conversation_summaries.db,conversations,crashes,history.jsonl,implicit,jetbox_summaries_proto.pb,knowledge,log,presence}
  rm -rf "$h"/.gemini/antigravity-cli/cache/{conversation_metadata,last_conversations}.json
done
EOF
