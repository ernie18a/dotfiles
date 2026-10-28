source /etc/bash_completion.d/* 2>/dev/null
export CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR=1
export CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN=1
export npm_config_dangerously_allow_all_scripts=true
export DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical NEEDRESTART_SUSPEND=1 UCF_FORCE_CONFFOLD=1
#export CLAUDE_CODE_SUBAGENT_MODEL=haiku
export COLORTERM=truecolor
export DBUS_SESSION_BUS_ADDRESS=/dev/null
export DEBCONF_NOWARNINGS="yes"
export DEBIAN_FRONTEND=noninteractive
export EDITOR=vim
export FIREBASE_KEY_PATH=~/.G/fb/.fb.55H.json
export GIT_EDITOR=vim
export HISTCONTROL=ignoredups:erasedups &>/dev/null
export HISTFILESIZE= &>/dev/null
export HISTSIZE= &>/dev/null
export KUBE_EDITOR=/bin/vim &>/dev/null
FQAI='- 簡短回覆 '
export MAILCHECK=0 &>/dev/null
export OLLAMA_API_BASE=http://127.0.0.1:11434
export PATH="$HOME/.grok/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/snap/bin:/opt/homebrew/bin:$HOME/.docker/cli-plugins:$HOME/bin:$HOME/.google-cloud-sdk/bin/"
export PYTHONPYCACHEPREFIX="$HOME/.cache/pycache"
export TERM=xterm-256color
export UV_VENV_CLEAR=1
export WIN_USER=`ls /mnt/c/Users 2>/dev/null |grep -iv "All\|Default\|desktop.ini\|Public\|USER\|Administrator\|super"`
export WIN_USER_DIR=/mnt/c/Users/$WIN_USER
if [ -f '/home/e/.google-cloud-sdk/completion.bash.inc' ]; then . '/home/e/.google-cloud-sdk/completion.bash.inc'; fi
if [ -f '/home/e/.google-cloud-sdk/path.bash.inc' ]; then . '/home/e/.google-cloud-sdk/path.bash.inc'; fi
export PS1="[ \\u@\\h \w \$(git rev-parse --abbrev-ref HEAD 2>/dev/null)] \\$ "
PROMPT_COMMAND=' history -a '
source ~/.55H 2>/dev/null
touch ~/.hushlogin
# alias MKT=' cd $(mktemp -d /tmp/XXX) '
alias CDB=' mkdir -p ~/.BACKUP 2>/dev/null ; cd ~/.BACKUP 2>/dev/null ;   ls -1p --color '
alias TOP=' top -o %MEM '
alias PP='  until ssh 192.168.213.199 2>/dev/null ; do :; done '
alias BKUP=' mkdir ~/.BACKUP 2>/dev/null ; cd ~/.BACKUP ; ls -l '
alias TTY=' stty sane ; clear '
alias SHORT='printf "%s\n" "$FQAI" > ./AGENTS.md'
alias mic='micro -softwrap true -wordwrap true'
alias MM2=' DEV=$(blkid -L g) && sudo mount -o defaults,noatime,commit=300 $DEV /g '
alias MM=" DEV=\$(blkid -L g) && sudo mount -o defaults,noatime,commit=300 \$DEV /g "
# alias SHORTS='for DIR in ./*/; do printf "%s\n" "$FQAI" > "$DIR/AGENTS.md" ; done'
alias UU=' GRCA & GGRCA & wait '
alias TMUX=' bash ~/.G/dotfiles/curl/u.gcptmux.sh || curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/u.gcptmux.sh | bash '
alias AC='agy --model claude-sonnet-4-6 --dangerously-skip-permissions'
alias AG='agy --model gemini-3.8-flash --effort high --dangerously-skip-permissions'
alias AR='agy -c --dangerously-skip-permissions'
AGP() { sudo apt-get purge -y --autoremove "$@" && dpkg -l | grep '^rc' | awk '{print $2}' | xargs sudo apt-get purge -y && sudo apt-get autoremove --purge -y && sudo apt-get clean ; }
alias APT=' bash -c "curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.apt.sh" | bash -s -- '
alias bcl=' bat -ppl '
alias bcb=' bat -ppl bash '
alias bcm=' bat -ppl md '
alias bcp=' bat -ppl py '
alias bcy=' bat -ppl yml '
alias CAL=' cal $(date +%Y) '
alias caat=' cat '
alias car=' cat '
alias cart=' cat '
alias catr=' cat '
alias caty=' cat '
alias cay=' cat '
alias cayt=' cat '
alias CGC=' cat .git/config | grep url '
alias SPK=' cat ~/.ssh/id_ed25519.pub '
alias SKILL=' cd  ~/.G/dotfiles/skills ; ls -1p --color '
alias CDW=' cd $WIN_USER_DIR '
alias CDWE=' cd $WIN_USER_DIR/Desktop ;  ls -1p --color '
alias CDWO=' cd $WIN_USER_DIR/Downloads ;  ls -1p --color '
alias ..=' cd ../ '
alias ...=' cd ../../ '
alias ....=' cd ../../../ '
alias CDD=' cd /g/data ;  ls -1p --color '
alias CDH=' cd /g/hedge/ ;  ls -1p --color '
alias CDP=' cd /g/private/ ;  ls -1p --color '
alias CDT=' cd /g/tools/ ;   ls -1p --color '
alias CDV=' cd /g/av/ ;   ls -1p --color '
alias CDS=' cd /g/stts/ ;   ls -1p --color '
alias CDY=' cd /g/ypp/ ;   ls -1p --color '
CD() { cd /g/*/"$1"/ && ls -1p --color; }
_CD() { local d; COMPREPLY=(); for d in /g/*/"$2"*/; do COMPREPLY+=("${d#/g/*/}"); done; }; complete -o nospace -F _CD CD
alias VBP=' cd ~/.G/dotfiles ; git pull >/dev/null ; vim ~/.G/dotfiles/home/.bash_profile ; git rm -r --cached . >/dev/null ; git add -A && git commit -amVBP &> /dev/null && git push 1>/dev/null ; cd - &>/dev/null '
alias CDg=' cd /g/ ; ls -1p --color '
alias CDFH=' cd ~/.G/dotfiles/home ; ls -1p --color '
alias CDFC=' cd ~/.G/dotfiles/curl/ ; ls -1p --color ' 
alias VNP=' cd ~/.G/dotfiles ; git pull >/dev/null ; vim ~/.G/dotfiles/notes/commands.txt ; git rm -r --cached . >/dev/null ; git add -A && git commit -amVNP &> /dev/null && git push 1>/dev/null ; cd - &>/dev/null '
alias VEP=' cd ~/.G/dotfiles ; git pull >/dev/null ; vim ~/.G/dotfiles/notes/eng.txt ; git rm -r --cached . >/dev/null ; git add -A && git commit -amVEP &> /dev/null && git push 1>/dev/null ; cd - &>/dev/null '
alias LR='claude --dangerously-skip-permissions --resume'
alias LOPR='claude --model opusplan --effort high --permission-mode plan --allow-dangerously-skip-permissions --resume'
alias LS='claude --model sonnet --effort high --dangerously-skip-permissions'
alias LH='claude --model haiku --effort high --dangerously-skip-permissions'
alias LO='claude --model opus --effort high --dangerously-skip-permissions'
alias LOM='claude --model opus --effort medium --dangerously-skip-permissions'
alias LOL='claude --model opus --effort low --dangerously-skip-permissions'
# alias LOP='claude --model opusplan --effort medium --dangerously-skip-permissions'
alias LOP=' claude --model opusplan --effort high --permission-mode plan --allow-dangerously-skip-permissions '
alias OR='codex --yolo resume'
alias OA='codex --yolo -m gpt-6-astra -c model_reasoning_effort=medium'
alias OAL='codex --yolo -m gpt-6-astra -c model_reasoning_effort=low'
alias OSL='codex --yolo -m gpt-6.1-sol -c model_reasoning_effort=low'
alias OS='codex --yolo -m gpt-6.1-sol -c model_reasoning_effort=medium'
alias OSH='codex --yolo -m gpt-6.1-sol -c model_reasoning_effort=high'
alias OL='codex --yolo -m gpt-6-luna -c model_reasoning_effort=high'
alias co=' cp '
alias cp=' cp -urf '
alias CDZ=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.danger.zone.sh | bash '
alias CMTZ=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.git.reset.sh | bash '
alias NBP=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.new_bash_profile.sh | bash '
alias BAT=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.bat.sh | bash '
alias IPP=' curl ipinfo.io ; curl ifconfig.io '
alias DET=' deactivate '
alias DU=' du -sh . ; du -hd1 2>/dev/null |grep "G\|M" '
alias QUOTE=' echo -e "\nflexibility to improve adaptability\n\nuser-level instructions\n遞增的邊際效益 (Increasing Marginal Returns)\n妥協\n" '
alias GGG2=' eval "$(ssh-agent -s)" ; ssh-add ~/.ssh/id_ed25519 ; gcloud compute ssh gcp --ssh-flag="-A" --ssh-flag="-L 1455:localhost:1455" '
alias GGG=' eval "$(ssh-agent -s)" ; ssh-add ~/.ssh/id_ed25519 ; ssh -A -F ~/.ssh/gcp_config gcp '
alias PUSH="git add -A && git commit -mPUSH --no-verify && git pull --rebase && git push --no-verify"
alias PUSH2="git fetch && git add -A && git commit -mPUSH --no-verify && git push --no-verify --force"
alias PUSH3="git add -A && git commit -mPUSH --no-verify && git pull --rebase && git push --no-verify --force"
alias PUSH4="git add -A && git commit -mPUSH --no-verify && git pull -X ours --no-verify && git push --no-verify"
alias PUSH5="git pull >/dev/null && git add -A && git commit -mPUSH --no-verify && git push --no-verify"
alias GRC='git fetch --prune && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD) && git clean -fd'
alias FINDD=' find . -iname 2>/dev/null '
alias TEST2=' for i in *.py; do stdbuf -oL -eL uv run --no-project "$i" 2>&1 | tee -a log; done '
alias TEST=' for i in *.py; do uv run --no-project "$i" 2>&1 | tee -a log; done '
alias GCO=' git checkout '
alias GC=' git clone '
alias GCGR=' git config --get remote.origin.url '
alias GS=' git status '
GV() { grep -Ev "^\s*(#|$)" ; }
alias GR=' grep -R --color 2>/dev/null '
alias G=' grep -i --color '
alias GIP=' grep -iE --color "([0-9]{1,3}[\.]){3}[0-9]{1,3}" '
alias GRI=' grep -ri --color 2>/dev/null '
alias V=' grep -v '
alias VE=' grep -vE '
alias GURL=' grep -vE 127.0.0\|log.*log\|index\|1.2.3 | grep -E "([a-zA-Z0-9]+\.[a-zA-Z0-9]+\.[a-zA-Z0-9]+)" '
alias LTH2=' gsed -i "/PUSHM\|rere\|nmap\|nc\|.bash_history\|help\|CNG\|CBG\|reboot\|poweroff\|HISTFILE\|help\|mtr\|gping\|BRC\|wget\|NC\|ping\|curl\|HG\|HH\|LTH\|STEALTH\|source\|SAS\|export\|history\|rm\|ernie18a\|sshrc\|rsync\|scp\|scpr/d" ~/.bash_history ; rm -rf /tmp/*sshrc* '
alias lld=' ls --color -Ald */ .*/ '
alias ll=' ls -1p --color '
alias lg=' ls -Ah |grep -i --color '
alias lll=' ls -Alh --color '
alias kk=' ls -l --color '
alias llh=' ls -lh --color '
alias CDG=' mkdir ~/.G &>/dev/null ; cd ~/.G/* 2>/dev/null || { cd ~/.G && ls -1p --color  ; } '
alias NC=' nc -zvw2 '
alias PS5='ps -eo %cpu,%mem,comm --sort=-%cpu | head -n 6 && ps -eo %cpu,%mem,comm --sort=-%mem | head -n 6'
alias PY=' python3 '
alias RMRF=' rm -rf '
alias rm=' rm -rf '
alias RMDIR=' rm -rf -- */ '
alias RSYNC=' rsync -ruzvP '
alias scpr=' scp -rC '
alias SHK=' sort -hk '
#alias SB=' source ~/.G/dotfiles/home/.bash_profile 2>/dev/null || source /dev/stdin <<< "$(curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile)" ; cd - &>/dev/null '
alias SB=' source ~/.G/dotfiles/home/.bash_profile ; cd - 2>/dev/null '
alias SB2=' source ~/.G/dotfiles/home/.bash_profile '
alias SS=' ss -lutn '
alias SSG=' ss -lutn |grep -i --color '
alias S86=' ssh 192.168.213.86 '
alias AGG=' sudo apt-get update >/dev/null ; apt list |tee ~/.APT |grep -i --color '
alias AGI=' sudo apt-get update >/dev/null ; sudo apt-get install -y >/dev/null '
alias llllg=' sudo find . |grep -i '
alias PI=' sudo npm install -g --ignore-scripts @earendil-works/pi-coding-agent '
alias tmprm=' sudo rm -rf /tmp/{,.}* 2>/dev/null ; cd /tmp '
alias SU=' sudo su - '
alias SUF=' sudo su - f '
alias SUN=' sudo su - n '
alias SUO=' sudo su - o '
alias SYSD=' sudo systemctl disable '
alias SYSE=' sudo systemctl enable '
alias SYSR=' sudo systemctl restart '
#UUU() { sudo systemctl restart systemd-timesyncd ; sudo npm install -g npm ; sudo npm install -g @openai/codex ; sudo npm install -g @anthropic-ai/claude-code ; sudo agy update ; sudo apt update -qq ; }
UUU() { sudo npm install -g npm ; sudo npm install -g @openai/codex ; claude update ; sudo agy update ; }
alias SYSS=' sudo systemctl stop '
alias SVH=' sudo vim /mnt/c/Windows/System32/drivers/etc/hosts '
alias LUF=' systemctl list-unit-files |grep -i '
alias SYS=' systemctl status '
alias ZCF=' tar -zcf '
alias CF=' tar cf '
alias XF=' tar xf '
alias tmuxad=' tmux a -d 2>/dev/null || tmux '
alias TR=' tr "[:upper:]" "[:lower:]"  | grep -Ev "^\s*(#|$)" |  awk "{print \$1\" \"\$2}" | sort '
alias TC=' tree -Ca '
alias TCG=' tree -Ca |grep -i --color $1'
alias TCL=' tree -CaL $1'
alias vin=' vim '
alias vum=' vim '
alias vun=' vim '
alias vvim=' vim '
alias VGP='cd ~/.G/dotfiles ; git pull >/dev/null ; vim ~/.G/dotfiles/home/GEMINI.md ; git rm -r --cached . >/dev/null ; git add -A && git commit -amVGP &> /dev/null && git push 1>/dev/null ; cd - &>/dev/null'
WATCH() { watch "$@" ; }
DIG() { dig $1 | grep -vE ^\;\|^$ ; }
lgc() { cat $(ls -Ah |grep -i $1 ) || ls -Ah | grep -i $i ; }
lgv() { vim $(ls -Ah |grep -i $1 ) || ls -Ah | grep -i $i ; }
WHOIS() { whois $1 | grep -Ev "^\s*(#|$)" |grep -i NetName ; }
AWK() { awk $2 "{print\$$1}" ; }
ECDZ() { echo 'source ~/.G/dotfiles/home/.bash_profile 2>/dev/null || source /dev/stdin <<< "$(curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile)"' |tee ~/.bash_profile ; }
l() { ls -A | grep "^\." | xargs -d '\n' ls -d --color ; }
CBG() { { curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/home/.bash_profile || cat ~/.G/dotfiles/home/.bash_profile 2>/dev/null || cat ~/.bash_profile 2>/dev/null; } | grep -i --color "$1" 2>/dev/null; }
DF() { df -h |sort -hk2 |sed -e 1b -e '$!d' ; }
SEDID() { sed -i "/$1/d" $2 ; }
SEDIS() { sed -i "s/$1/$2/g" $3 ; }
mvim() { mkdir -p "$(dirname "$1")" && vim "$1"; }
MTK() { mkdir ./$1 ; touch ./$1/.gitkeep; }
GGRCA2() { (cd /g; for R in */; do (U=$(git -C "$R" remote get-url origin) && sudo rm -rf "$R" && git clone -q "$U" "$R") & done; wait); }
#GGRCA() { (cd /g; for R in */; do [[ -d "$R/.git" ]] || continue; (cd "$R"; git fetch -p && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD) && git clean -fd) & done; wait); }
GRCA2() { (cd ~/.G; for R in */; do (U=$(git -C "$R" remote get-url origin) && sudo rm -rf "$R" && git clone -q "$U" "$R") & done; wait); }
#GRCA()  { (cd ~/.G; for R in */; do (cd "$R"; git fetch -p && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD) && git clean -fd) & done; wait); }
GGRCA() { (cd /g; for R in */; do (cd "$R"; git fetch -p && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD) && git clean -fd) & done; wait); }
GRCA()  { (cd ~/.G; for R in */; do (cd "$R"; git fetch -p && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD) && git clean -fd && git gc -q) & done; wait); }
EOIE() { bash ~/.G/dotfiles/curl/u.error.object.is.empty.sh || curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/u.error.object.is.empty.sh | bash; }
AGS() { (for i in /g/*/ ~/.G/*/; do git -C $i status -s | sed "s|^|$i|" & done; wait); }
AGS3() { (for i in /g/*/ ~/.G/*/; do git -C $i status -s & done; wait); }
AGS2() { (for i in /g/*/ ~/.G/*/; do (git -C $i fetch -q; git -C $i status -sb | grep -v "^## [^[]*$" | sed "s|^|$i|") & done; wait); }
AGSP() { (for i in /g/*/ ~/.G/*/; do (git -C $i add -A; git -C $i commit -mPUSH --no-verify; git -C $i pull --rebase; git -C $i push --no-verify) & done; wait); }
sl() { for SOMETHING in $(cat ./$1); do $2 $SOMETHING; done; }
#CIO() { if [ -n "$1" ]; then cp -urf "$1" /mnt/c/Users/e/Desktop/; else cp -urf ./* /mnt/c/Users/e/Desktop/; fi; }
CIO() { if [ "$#" -gt 0 ]; then cp -urf "$@" /mnt/c/Users/e/Desktop/; else cp -urf ./* /mnt/c/Users/e/Desktop/; fi; }
#COI() { if [ -n "$1" ]; then cp -urf "/mnt/c/Users/e/Downloads/$1" .; else cp -urf /mnt/c/Users/e/Downloads/* .; fi; }
COI() { if [ "$#" -gt 0 ]; then local f=(); for x in "$@"; do f+=(/mnt/c/Users/e/Downloads/$x); done; cp -urf "${f[@]}" .; else cp -urf /mnt/c/Users/e/Downloads/* .; fi; }
COI2() { if [ "$#" -gt 0 ]; then cp -urf "${@/#//mnt/c/Users/e/Downloads/}" .; else cp -urf /mnt/c/Users/e/Downloads/* .; fi; }
UR() { if [ -n "$1" ]; then uv run --no-project "$@"; else uv run --no-project main.py; fi; }
ACL() { sudo chown -R e:g /g & sudo find /g -type d -exec chmod 2770 {} + & sudo find /g -type f -exec chmod 660 {} + & sudo setfacl -R -m d:u::rwx,d:g::rwx,d:o::-,d:m::rwx /g & wait; }
PING() { for i in $(seq 0 255) ; do ping $1.$i -c1 -W1 & done |grep from |awk '{print $4}' |awk -F: '{print $1}' | sort -V ; }
WAIT() { while pgrep -f "$1" > /dev/null; do sleep 9; done ; }
KILL() { sudo pkill -9 -fi "$1"; }
PUSHM() { git pull >/dev/null ; git rm -r --cached . > /dev/null ; git add -A && git commit -m "$@" &>/dev/null && git push;}
USAGE() { sudo bash ~/.G/dotfiles/curl/u.usage.sh || curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/u.usage.sh | sudo bash; }
USAGE2() { sudo uv run /g/tools/usage/main2.py; }
# USAGE3() { sudo bash ~/.G/dotfiles/curl/u.usage3.sh || curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/u.usage3.sh | sudo bash; }
# USAGE4() { sudo bash ~/.G/dotfiles/curl/u.usage4.sh || curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/u.usage4.sh | sudo bash; }
# USAGE5() { sudo bash ~/.G/dotfiles/curl/u.usage5.sh || curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/u.usage5.sh | sudo bash; }
# USAGE6() { sudo bash ~/.G/dotfiles/curl/u.usage6.sh || curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/u.usage6.sh | sudo bash; }
# USAGE7() { sudo bash ~/.G/dotfiles/curl/u.usage7.sh || curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/u.usage7.sh | sudo bash; }
AT() { local t=$(( $(date -d "${1:0:2}:${1:2:2}" +%s) - $(date +%s) )); sleep $(( t < 0 ? t + 86400 : t )); }
TOOK() { local s=$SECONDS; date +%d:%H:%M; trap : INT; eval "$@"; trap - INT; local d=$((SECONDS-s)); printf '%d:%02d:%02d:%02d\n' $((d/86400)) $((d%86400/3600)) $((d%3600/60)) $((d%60)); }
AGAIN() { local t=$(( 10#${1:0:2}*3600 + 10#${1:2:2}*60 )); shift; while :; do eval "$@"; sleep $t; done ; }
CNG() { cat ~/.G/dotfiles/notes/commands.txt 2>/dev/null |grep -i --color $1 || curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/notes/commands.txt |grep -i --color $1 ; }
CT() { cat ~/.T$1 2>/dev/null ; }
VT() { vim ~/.T$1 ; }
HG() { cat ~/.bash_history | grep -ai --color "$1" ; }
# CG() { cat ~/.gemini/GEMINI.md 2>/dev/null || curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/home/GEMINI.md ; }
alias CG=' cat  ~/.G/dotfiles/home/GEMINI.md '
alias CGG=' cat  ~/.G/dotfiles/home/GEMINI.md | grep -i --color '
MCP() { kill -0 $(cat /tmp/mcp.pid) 2>/dev/null || setsid -f bash -c 'echo $$ >/tmp/mcp.pid; exec bash /g/tools/mcp/server.sh' &>/tmp/mcp.log ; }
MCPS() { kill -- -$(cat /tmp/mcp.pid) 2>/dev/null ; rm -f /tmp/mcp.pid ; }
MEM() { sudo bash -c 'ps -u "$1" -o pid=,rss= --sort=rss | tail -30 | while read p r; do cd /proc/$p/cwd; f=$(tr "\0" "\n" </proc/$p/cmdline | tail -n +2 | while read a; do [ -f "$a" ] && realpath "$a" && break; done); echo "$(numfmt --from-unit=1024 --to=iec $r) ${f:-$(readlink /proc/$p/exe)}"; done 2>/dev/null' _ "$USER"; free | awk '/^Mem:/{printf "%.1f%%\n", $3/$2*100}'; }
MEM2() { sudo bash -c 'ps -eo pid=,rss= --sort=rss | tail -30 | while read p r; do cd /proc/$p/cwd; f=$(tr "\0" "\n" </proc/$p/cmdline | tail -n +2 | while read a; do [ -f "$a" ] && realpath "$a" && break; done); echo "$(numfmt --from-unit=1024 --to=iec $r) ${f:-$(readlink /proc/$p/exe)}"; done 2>/dev/null'; free | awk '/^Mem:/{printf "%.1f%%\n", $3/$2*100}'; }
