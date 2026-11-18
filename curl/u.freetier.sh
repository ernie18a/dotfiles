#!/usr/bin/env bash
# 對 e n o 的 agy 兩組模型與 codex 各送一次 hi，讓免費額度的倒數計時開始
# 用法：bash u.freetier.sh（非 root 時自動以 sudo 重新執行）
# 九個呼叫同時並行；只連結認證、MCP 為空、停用工具，避免載入使用者環境
# 每個子程序以 PR_SET_PDEATHSIG 綁定父程序，主腳本死亡時一併被 SIGKILL
[ "$EUID" -eq 0 ] || exec sudo bash "$0"
trap 'kill 0' INT TERM

AGY='h=~/.cache/freetier/agy; mkdir -p $h/.gemini/config; ln -sfn ~/.gemini/antigravity-cli $h/.gemini/antigravity-cli; echo {} >$h/.gemini/config/mcp_config.json; cd $h
echo "{\"event\":\"user\",\"message\":{\"content\":\"hi\"}}" | HOME=$h setpriv --pdeathsig KILL agy --model "$0" --input-format stream-json --output-format stream-json --dangerously-skip-permissions --disable-slash-commands --print= | tail -n 1 | jq -e ".result.status == \"SUCCESS\"" >/dev/null'

CODEX='h=~/.cache/freetier/codex; mkdir -p $h; ln -sfn ~/.codex/auth.json $h/auth.json; cd $h
echo hi | CODEX_HOME=$h setpriv --pdeathsig KILL codex exec --ephemeral --ignore-user-config --ignore-rules --skip-git-repo-check --sandbox read-only -c model="\"$0\"" -c model_reasoning_effort="\"low\"" -c web_search="\"disabled\"" -c skills.bundled.enabled=false --disable apps --disable plugins --disable remote_plugin --disable shell_tool --disable shell_snapshot --disable view_image --disable image_generation --disable multi_agent - >/dev/null 2>&1'

kick() {
  setpriv --reuid "$1" --regid "$1" --init-groups --reset-env --pdeathsig KILL bash -c "$2" "$3" 2>/dev/null \
    && echo "OK    $1 $3" || echo "FAIL  $1 $3"
}

for u in e n o; do
  kick "$u" "$AGY" gemini-3.8-flash-low &
  kick "$u" "$AGY" gpt-oss-120b-medium &
  kick "$u" "$CODEX" gpt-6-luna &
done
wait
