#!/usr/bin/env bash
# codex / claude / agy 剩餘額度，依 provider 分表，e 的列以 provider 名稱標示
# 用法：sudo bash u.usage4.sh
declare -A L=([n]="🐸 n" [o]="👾 o")
DUR='def dur: (. - now | floor) as $s | if $s <= 0 then "now" elif $s >= 86400 then "\($s / 86400 | floor)d \($s % 86400 / 3600 | floor)h" else "\($s / 3600 | floor)h \($s % 3600 / 60 | floor)m" end;'

codex_q() {
  coproc C { sudo -n -u "$1" -H timeout 30 codex app-server --listen stdio:// 2>/dev/null; }
  printf '%s\n' \
    '{"method":"initialize","id":1,"params":{"clientInfo":{"name":"usage","title":"usage","version":"0.0.0"},"capabilities":{}}}' \
    '{"method":"account/rateLimits/read","id":2,"params":null}' >&"${C[1]}"
  while IFS= read -r l <&"${C[0]}"; do
    case $l in *rateLimits*|*'"error"'*) break;; esac
  done
  kill "$C_PID"
  jq -r --arg u "$1" --arg l "${L[$1]:-codex}" "$DUR"'def c: if . then "\(100 - .usedPercent | round)% \(.resetsAt | dur)" else "-" end;
    .result.rateLimits // empty | "1\t\($u)\t\($l)\t\(.planType)\t\(.primary | c)\t\(.secondary | c)"' <<<"$l"
}

claude_refresh() {
  r=$(jq '.claudeAiOauth | {grant_type: "refresh_token", refresh_token: .refreshToken, client_id: (.clientId // "9d1c250a-e61b-44d9-88ed-5944d1962f5e"), scope: (.scopes | join(" "))}' "$1" \
    | curl -s -X POST https://platform.claude.com/v1/oauth/token -H 'content-type: application/json' -d @-)
  new=$(jq --argjson r "$r" '.claudeAiOauth += {accessToken: $r.access_token, refreshToken: ($r.refresh_token // .claudeAiOauth.refreshToken), expiresAt: ((now + $r.expires_in) * 1000 | floor), scopes: ($r.scope | split(" "))}' "$1")
  printf '%s\n' "$new" > "$1"
  jq -r '.claudeAiOauth.accessToken' "$1"
}

claude_q() {
  f=$(eval echo "~$1")/.claude/.credentials.json
  [ -f "$f" ] || return
  tok=$(jq -r '.claudeAiOauth | select(.expiresAt / 1000 > now + 30) | .accessToken' "$f")
  [ -n "$tok" ] || tok=$(claude_refresh "$f")
  curl -s https://api.anthropic.com/api/oauth/usage \
    -H "Authorization: Bearer $tok" -H 'anthropic-beta: oauth-2025-04-20' -H 'User-Agent: claude-code/2.1.283' \
    | jq -r --arg u "$1" --arg l "${L[$1]:-claude}" "$DUR"'def c: if . then "\(100 - .utilization | round)% \(.resets_at | sub("\\.[0-9]+"; "") | sub("[+]00:00$"; "Z") | fromdateiso8601 | dur)" else "-" end;
      "2\t\($u)\t\($l)\t\(.five_hour | c)\t\(.seven_day | c)"'
}

# 看到提示列才送 /usage，兩組額度都出現就結束，不用固定 sleep
agy_q() {
  coproc A { sudo -i -u "$1" script -qfc 'stty rows 80 cols 300; /bin/agy' /dev/null 2>/dev/null; }
  out= sent= n=0
  while IFS= read -r -t 30 x <&"${A[0]}"; do
    out+=$x$'\n'
    case $x in
      *Confirm*) printf '\r' >&"${A[1]}";;
      *'for shortcuts'*) [ -n "$sent" ] || { sent=1; printf '/usage\r' >&"${A[1]}"; };;
      *'Refreshes in'*|*'Quota available'*) ((++n == 2)) && break;;
    esac
  done
  kill "$A_PID"
  printf '%s' "$out" \
    | sed 's/\x1b\[[0-9;?]*[a-zA-Z]//g; s/\x1b\][^\x07]*\x07//g' | tr '\r' '\n' \
    | awk -v u="$1" -v l="${L[$1]:-agy}" 'BEGIN {M["d"] = 86400; M["h"] = 3600; M["m"] = 60; G = "GEMINI MODELS"; C = "CLAUDE AND GPT MODELS"; c[G] = c[C] = "-"}
        $0 ~ G || $0 ~ C {g = $0; sub(/^ +/, "", g)}
        g && /%$/ {p = $NF + 0}
        g && /Quota available/ {c[g] = "100% -"; g = ""}
        g && /Refreshes in/ {sub(/.*Refreshes in /, ""); s = 0; for (i = 1; i <= NF; i++) s += ($i + 0) * M[substr($i, length($i))]
          c[g] = sprintf("%d%% %s", p + 0.5, s >= 86400 ? int(s / 86400) "d " int(s % 86400 / 3600) "h" : int(s / 3600) "h " int(s % 3600 / 60) "m"); g = ""}
        END {printf "3\t%s\t%s\t%s\t%s\n", u, l, c[G], c[C]}'
}

# 每個 provider 的三個使用者查完就先印出該表
table() {
  for u in e n o; do "$1" "$u" & done | sort | cut -f3- | column -t -s $'\t'
  echo
}

date +%H%M
table codex_q &
table claude_q &
table agy_q &
wait
