#!/usr/bin/env bash
# codex / claude / agy 剩餘額度，依 provider 分表，e 的列以 provider 名稱標示
# 用法：sudo bash u.usage3.sh
# 使用者、工具、作業系統不固定：錯誤一律丟棄，查不到的列不印
exec 2>/dev/null
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
  # 刷新失敗（回應不是 JSON 或沒有 access_token）就不寫回，避免憑證檔被清空
  new=$(jq --argjson r "$r" 'select($r.access_token) | .claudeAiOauth += {accessToken: $r.access_token, refreshToken: ($r.refresh_token // .claudeAiOauth.refreshToken), expiresAt: ((now + $r.expires_in) * 1000 | floor), scopes: ($r.scope | split(" "))}' "$1") && [ -n "$new" ] || return
  printf '%s\n' "$new" > "$1"
  jq -r '.claudeAiOauth.accessToken' "$1"
}

claude_q() {
  f=$(eval echo "~$1")/.claude/.credentials.json
  [ -f "$f" ] || return
  tok=$(jq -r '.claudeAiOauth | select(.expiresAt / 1000 > now + 30) | .accessToken' "$f")
  [ -n "$tok" ] || tok=$(claude_refresh "$f") || return
  curl -s https://api.anthropic.com/api/oauth/usage \
    -H "Authorization: Bearer $tok" -H 'anthropic-beta: oauth-2025-04-20' -H 'User-Agent: claude-code/2.1.283' \
    | jq -r --arg u "$1" --arg l "${L[$1]:-claude}" "$DUR"'def c: if . then "\(100 - .utilization | round)% \(.resets_at | if . then sub("\\.[0-9]+"; "") | sub("[+]00:00$"; "Z") | fromdateiso8601 | dur else "available" end)" else "-" end;
      select(.five_hour or .seven_day) | "2\t\($u)\t\($l)\t\(.five_hour | c)\t\(.seven_day | c)"'
}

# 看到提示列才送 /usage，收到首筆額度後改短逾時以相容無 Argon 方案，收滿 5 筆即結束
# 未登入時 TUI 會一直轉圈，read -t 只管單行閒置，整體上限交給 timeout
# MCP 即使 disabled 仍會卡住啟動約 10 秒，改用只連結 antigravity-cli、MCP 設定為空的 HOME
agy_q() {
  coproc A { sudo -u "$1" -H timeout 40 bash -c 'cd; h=~/.cache/usage5; mkdir -p $h/.gemini/config; ln -sfn ~/.gemini/antigravity-cli $h/.gemini/antigravity-cli; echo {} >$h/.gemini/config/mcp_config.json; HOME=$h script -qfc "stty rows 80 cols 300; /bin/agy" /dev/null' 2>/dev/null; }
  out= sent= n=0 t=30
  while IFS= read -r -t "$t" x <&"${A[0]}"; do
    out+=$x$'\n'
    case $x in
      *Confirm*) printf '\r' >&"${A[1]}";;
      *'for shortcuts'*) [ -n "$sent" ] || { sent=1; printf '/usage\r' >&"${A[1]}"; };;
      *'Refreshes in'*|*'Quota available'*) [ -n "$sent" ] && { t=2; ((++n >= 5)) && break; };;
    esac
  done
  kill "$A_PID"
  printf '%s' "$out" \
    | sed 's/\x1b\[[0-9;?]*[a-zA-Z]//g; s/\x1b\][^\x07]*\x07//g' | tr '\r' '\n' \
    | awk -v u="$1" -v l="${L[$1]:-agy}" '
        BEGIN {
          M["d"] = 86400; M["h"] = 3600; M["m"] = 60; M["s"] = 1
          c["G","5h"] = c["G","7d"] = c["C","5h"] = c["C","7d"] = c["A","7d"] = "-"
        }
        /GEMINI .*ARGON/ || /Argon Weekly Limit/ {g = "A"; w = (/Weekly Limit/ ? "7d" : ""); next}
        /GEMINI MODELS/ || (/Models within this group/ && /Gemini/) {g = "G"; w = ""; next}
        /CLAUDE AND GPT MODELS/ || (/Models within this group/ && /Claude/) {g = "C"; w = ""; next}
        g && /Weekly Limit/ {w = "7d"; next}
        g && /Five Hour Limit/ {w = "5h"; next}
        g && w && match($0, /[0-9]+(\.[0-9]+)?%/) {p = substr($0, RSTART, RLENGTH - 1) + 0}
        g && w && /Quota available/ {c[g, w] = "100% available"; w = ""; next}
        g && w && /Refreshes in/ {
          sub(/.*Refreshes in /, "")
          s = 0
          for (i = 1; i <= NF; i++) s += ($i + 0) * M[substr($i, length($i))]
          c[g, w] = sprintf("%d%% %s", p + 0.5, s >= 86400 ? int(s / 86400) "d " int(s % 86400 / 3600) "h" : int(s / 3600) "h " int(s % 3600 / 60) "m")
          w = ""
        }
        END {
          if (c["G","5h"] != "-" || c["G","7d"] != "-" || c["C","5h"] != "-" || c["C","7d"] != "-" || c["A","7d"] != "-")
            printf "3\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n", u, l, c["G","5h"], c["G","7d"], c["C","5h"], c["C","7d"], c["A","7d"]
        }'
}

# column 會把色碼算進欄寬，排版後才依內容上色：重置 12h 內綠、12h~72h 黃、其餘預設色；0% 不能用，整格改暗灰
paint() {
  local G=$'\e[32m' Y=$'\e[33m' D=$'\e[38;5;238m' Z=$'\e[0m'
  sed -E "s/^codex\b/"$'\e[96m'"&$Z/; s/^claude\b/"$'\e[95m'"&$Z/; s/^agy\b/"$'\e[93m'"&$Z/
    s/\b([0-9]|1[01])h [0-9]+m\b/$G&$Z/g; s/\b(1[2-9]|2[0-3])h [0-9]+m\b/$Y&$Z/g
    s/\b[12]d [0-9]+h\b/$Y&$Z/g
    s/\b(now|available)\b/$G&$Z/g
    s/(^|[^0-9])0% (\x1b\[[0-9]+m)?([0-9]+[dh] [0-9]+[hm])(\x1b\[0m)?/\1${D}0% \3$Z/g"
}

# 每個 provider 的三個使用者查完就先印出該表
table() {
  local raw
  raw=$(for u in e n o; do id "$u" >/dev/null || continue; "$1" "$u" & done | sort | cut -f3-)
  [ -z "$raw" ] && return
  [ -n "$2" ] && raw="$2"$'\n'"$raw"
  printf '%s\n\n' "$(printf '%s\n' "$raw" | column -t -s $'\t' | paint)"
}

date +%H%M
table codex_q &
table claude_q &
table agy_q $' \tG5h\tG7d\tC5h\tC7d\tArgon' &
wait
