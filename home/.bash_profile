FQAI='- 回答保持簡短, reply 前先刪除不符合使用者需求或問題的資訊'
if [ -f '/home/e/.google-cloud-sdk/path.bash.inc' ]; then . '/home/e/.google-cloud-sdk/path.bash.inc'; fi
if [ -f '/home/e/.google-cloud-sdk/completion.bash.inc' ]; then . '/home/e/.google-cloud-sdk/completion.bash.inc'; fi
source /etc/bash_completion.d/* 2>/dev/null
#export BERT_MODELS_DIR=/g/.TMP/bert-models
#export CLOAKBROWSER_CACHE_DIR=/g/.TMP/cloakbrowser
export COLORTERM=truecolor
#export CUDA_CACHE_MAXSIZE=2147483647
#export CUDA_CACHE_PATH=/g/.TMP/cuda-cache
#export CUDA_DEVICE_MAX_CONNECTIONS=32
#export CUDA_MANAGED_FORCE_DEVICE_ALLOC=1
export DBUS_SESSION_BUS_ADDRESS=/dev/null
export DEBCONF_NOWARNINGS="yes"
export DEBIAN_FRONTEND=noninteractive
export EDITOR=vim
export FIREBASE_KEY_PATH=~/.G/fb/.fb.55H.json
export GIT_EDITOR=vim
#export HF_HOME=/g/.TMP/huggingface
#export HF_HUB_CACHE=/g/.TMP/huggingface/hub
export HISTCONTROL=ignoredups:erasedups &>/dev/null
export HISTFILESIZE= &>/dev/null
export HISTSIZE= &>/dev/null
#export HUGGINGFACE_HUB_CACHE=/g/.TMP/huggingface/hub
export KUBE_EDITOR=/bin/vim &>/dev/null
export MAILCHECK=0 &>/dev/null
#export MECABRC=/g/.TMP/mecab/mecabrc
#export MODELSCOPE_CACHE=/g/.TMP/modelscope
#export MPLCONFIGDIR=/g/.TMP/matplotlib
#export NUMBA_CACHE_DIR=/g/.TMP/numba-cache
#export NVM_DIR="$HOME/.nvm"
export OLLAMA_API_BASE=http://127.0.0.1:11434
#export OPEN_JTALK_DICT_DIR=/g/.TMP/open-jtalk-dict
export PATH="$HOME/.grok/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/snap/bin:/opt/homebrew/bin:$HOME/.docker/cli-plugins:$HOME/bin:$HOME/.google-cloud-sdk/bin/"
#export PIP_CACHE_DIR=/g/.TMP/pip-cache
#export PLAYWRIGHT_BROWSERS_PATH=/g/.TMP/playwright-browsers
#export PYTHONPYCACHEPREFIX=/g/.TMP/python-pycache
#export PYTORCH_KERNEL_CACHE_PATH=/g/.TMP/torch-kernel
#export TEMP=/g/.TMP/tmp
export TERM=xterm-256color
#export TMP=/g/.TMP/tmp
#export TMPDIR=/g/.TMP/tmp
#export TORCHINDUCTOR_CACHE_DIR=/g/.TMP/torchinductor-cache
#export TORCH_HOME=/g/.TMP/torch
#export TRANSFORMERS_CACHE=/g/.TMP/huggingface/transformers
#export TRITON_CACHE_DIR=/g/.TMP/triton-cache
#export ULTRALYTICS_DIR=/g/.TMP/ultralytics
#export UV_CACHE_DIR=/g/.TMP/uv-cache
export UV_VENV_CLEAR=1
export WIN_USER=`ls /mnt/c/Users 2>/dev/null |grep -iv "All\|Default\|desktop.ini\|Public\|USER\|Administrator\|super"`
export WIN_USER_DIR=/mnt/c/Users/$WIN_USER
#export XDG_CACHE_HOME=/g/.TMP/xdg-cache
export XDG_CONFIG_HOME=/g/.TMP/xdg-config
#export XDG_DATA_HOME=/g/.TMP/xdg-data
#export YOLO_CONFIG_DIR=/g/.TMP/ultralytics/config
#export YTDLP_CACHE_DIR=/g/.TMP/ytdlp-cache
#export YTDLP_PATHS=temp:/g/.TMP/ytdlp-temp
which git &>/dev/null && export PS1="[ \\u@\\h \w \$(git rev-parse --abbrev-ref HEAD 2>/dev/null)] \\$ " || export PS1="[ \\u@\\h \w ] \\$ "
PROMPT_COMMAND=' history -a '
source ~/.55H 2>/dev/null
#source ~/.IPS 2>/dev/null
touch ~/.hushlogin
WHEN() { local t=$(( $(date -d "${1:0:2}:${1:2:2}" +%s) - $(date +%s) )); sleep $(( t < 0 ? t + 86400 : t )); }
alias SPK=' cat ~/.ssh/id_ed25519.pub '
alias SHORTS='for DIR in ./*/; do printf "%s\n" "$FQAI" > "$DIR/AGENTS.md" ; done'
alias SHORT='printf "%s\n" "$FQAI" > ./AGENTS.md'

alias GGG=' eval "$(ssh-agent -s)" ; ssh-add ~/.ssh/id_ed25519 ; gcloud compute ssh gcp --ssh-flag="-A" --ssh-flag="-L 1455:localhost:1455" '
alias KKK=' cat ~/.55H '
alias UU=' GRCA & GGRCA & '
alias SKILL=' cd  ~/.G/dotfiles/skills ; ls -l --color '
# alias USAGE="  date ; sudo -i bash -lc 'cd /g/app/usage && uv run main.py'"
alias HYC='hermes --yolo -c'
alias HY='hermes --yolo'
alias MM2=' DEV=$(blkid -L g) && mountpoint -q /g || sudo mount -o defaults,noatime,commit=300 $DEV /g '
alias MM=" DEV=\$(blkid -L g) && mountpoint -q /g || sudo mount -o defaults,noatime,commit=300 \$DEV /g "
alias GY=' agy --dangerously-skip-permissions '
alias GYR=' agy -c --dangerously-skip-permissions '
alias AGP='sudo apt-get purge -y "$@" && dpkg -l | grep "^rc" | awk "{print \$2}" | xargs -r sudo apt-get purge -y && sudo apt-get autoremove --purge -y && sudo apt-get clean'
alias APT=' bash -c "curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.apt.sh" | bash -s -- '
alias bcl=' bat -ppl '
alias bcb=' bat -ppl bash '
alias bcjs=' bat -ppl js '
alias bcm=' bat -ppl md '
alias MD=' bat -ppl md *.md '
alias BR=' bat -ppl md README.md '
alias bcmr=' bat -ppl md README.md '
alias bcp=' bat -ppl py '
alias bcr=' bat -ppl rb '
alias bct=' bat -ppl tf '
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
alias CR=' cat ~/.RESEARCH.md 2>/dev/null '
alias CDW=' cd $WIN_USER_DIR '
alias CDWE=' cd $WIN_USER_DIR/Desktop ;  ls -1p --color '
alias CDWT=' cd $WIN_USER_DIR/Desktop/_tmp ;  ls -1p --color '
alias CDWO=' cd $WIN_USER_DIR/Downloads ;  ls -1p --color '
alias ..=' cd ../ '
alias ...=' cd ../../ '
alias ....=' cd ../../../ '
alias .....=' cd ../../../../ '
alias ......=' cd ../../../../../ '
alias ll=' ls -1p --color '
alias CDg=' cd /g ;  ls -1p --color '
alias CDA=' cd /g/app/ ; ls -1p --color '
alias CDN=' cd /g/nf/  ;   ls -1p --color '
alias CDT=' cd /g/tools/ ;   ls -1p --color '
alias CDP=' cd /g/private/ ;  ls -1p --color '
alias CDH=' cd /g/hedge/ ;  ls -1p --color '
alias VBP=' cd ~/.G/dotfiles ; git pull >/dev/null ; vim ~/.G/dotfiles/home/.bash_profile ; git rm -r --cached . >/dev/null ; git add -A && git commit -amVBP &> /dev/null && git push 1>/dev/null ; cd - &>/dev/null '
alias CDD=' cd ~/.G/dotfiles/ ; ls -1p --color '
alias CDDC=' cd ~/.G/dotfiles/curl/ ; ls -1p --color ' 
alias VNP=' cd ~/.G/misc/notes ; git pull >/dev/null ; vim ./commands.txt ; git rm -r --cached . > /dev/null ; git add -A && git commit -amVNP &> /dev/null && git push ; cd - &>/dev/null '
alias VEP=' cd ~/.G/misc/notes ; git pull >/dev/null ; vim ./eng.txt ; git rm -r --cached . > /dev/null ; git add -A && git commit -amVEP &> /dev/null && git push ; cd - &>/dev/null '
alias VPP=' cd ~/.G/private/yet ; git pull >/dev/null ; vim ./.RANDOM.txt; git rm -r --cached . > /dev/null ; git add -A && git commit -amVPP &> /dev/null && git push ; cd - &>/dev/null '
alias LYR=' claude  --model sonnet --dangerously-skip-permissions --resume '
alias LHY=' claude --model Haiku --dangerously-skip-permissions '
alias LOY=' claude --model Opus --dangerously-skip-permissions '
alias LY=' claude --model sonnet --dangerously-skip-permissions ' # --effort medium '
alias LLY=' claude --model sonnet --dangerously-skip-permissions --effort low '
# alias DY=' codex --yolo -m gpt-5.6-luna -c model_reasoning_effort=medium '
alias DY=' codex --yolo -m gpt-5.6-sol -c model_reasoning_effort=low '
alias DY4=' codex --yolo -m gpt-5.4-mini -c model_reasoning_effort=medium '
alias DYR=' codex resume --yolo '
alias co=' cp '
alias cp=' cp -urf '
alias CPWE=' cp ./$1 $WIN_USER_DIR/Desktop/ '
alias CDZ=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.danger.zone.sh | bash '
alias CMTZ=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.git.reset.sh | bash '
alias NBP=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.new_bash_profile.sh | bash '
alias USERSYNC=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.useradd.sh | bash '
alias VIMRC=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.vimrc.sh | bash '
alias BAT=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.bat.sh | bash '
alias CODEX=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.codex.sh | bash ' 
alias HERMES=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.hermes.sh | bash '
alias IPP=' curl ipinfo.io ; curl ifconfig.io '
alias DET=' deactivate '
alias DU=' du -sh . ; du -hd1 2>/dev/null |grep "G\|M" '
#alias QUOTE=' echo -e "\nflexibility to improve adaptability\n\nuser-level instructions\n" '
alias QUOTE=' echo -e "\nflexibility to improve adaptability\n\nuser-level instructions\n遞增的邊際效益 (Increasing Marginal Returns)\n" '
alias PUSH="git fetch && git add -A && git commit -mPUSH --no-verify && git push --no-verify --force"
alias GRC='git fetch --prune && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD) && git clean -fd'
alias FINDD=' find . -iname 2>/dev/null '
alias FIND=' find / -iname 2>/dev/null '
alias TEST2=' for i in *.py; do stdbuf -oL -eL uv run --no-project "$i" 2>&1 | tee -a log; done '
alias TEST=' for i in *.py; do uv run --no-project "$i" 2>&1 | tee -a log; done '
alias GCO=' git checkout '
alias GC=' git clone '
alias GCGR=' git config --get remote.origin.url '
alias GS=' git status '
alias GLNS=' glances --disable-plugin=sensors,amps,containers -t5'
alias GE=' grep -Ei --color '
alias GV=' grep -Ev "^\s*(#|$)" '
alias GVJ=' grep -Ev "^\s*(#|//|$)" '
alias GR=' grep -R --color 2>/dev/null '
alias G=' grep -i --color '
alias GIP=' grep -iE --color "([0-9]{1,3}[\.]){3}[0-9]{1,3}" '
alias GRI=' grep -ri --color 2>/dev/null '
alias V=' grep -v '
alias VE=' grep -vE '
alias GURL=' grep -vE 127.0.0\|log.*log\|index\|1.2.3 | grep -E "([a-zA-Z0-9]+\.[a-zA-Z0-9]+\.[a-zA-Z0-9]+)" '
alias LTH2=' gsed -i "/PUSHM\|rere\|nmap\|nc\|.bash_history\|help\|CNG\|CBG\|reboot\|poweroff\|HISTFILE\|help\|mtr\|gping\|BRC\|wget\|NC\|ping\|curl\|HG\|HH\|LTH\|STEALTH\|source\|SAS\|export\|history\|rm\|ernie18a\|sshrc\|rsync\|scp\|scpr/d" ~/.bash_history ; rm -rf /tmp/*sshrc* '
alias lld=' ls --color -Ald */ .*/ '
alias lg=' ls -Ah |grep -i --color '
alias lll=' ls -Alh --color '
alias kk=' ls -l --color '
# alias ll=' ls -l --color '
alias llh=' ls -lh --color '
# alias CDB=' mkdir ~/.BACKUP &>/dev/null ; cd ~/.BACKUP ; ls -A --color |sort '
alias CDG=' mkdir ~/.G &>/dev/null ; cd ~/.G/* 2>/dev/null || { cd ~/.G && ls -1p --color  ; } '
alias NC=' nc -zvw2 '
alias PS5=' ps aux | sort -nrk 3,3 | head -n 5 '
alias PUSH2="git pull >/dev/null && git add -A && git commit -mPUSH --no-verify && git push --no-verify"
alias PY=' python3 '
alias rm=' rm -rf '
alias RSYNC=' rsync -ruzvP '
alias scpr=' scp -rC '
alias SHK=' sort -hk '
alias SB=' source ~/.G/dotfiles/home/.bash_profile 2>/dev/null || source /dev/stdin <<< $(curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/home/.bash_profile) ; cd - &>/dev/null '
alias SS=' ss -lutn '
alias SSG=' ss -lutn |grep -i --color '
alias UUU=' sudo npm install -g npm ; sudo npm install -g @openai/codex ' # ; hermes update -y  ; sudo agy update ' # ;  sudo apt update && sudo apt install claude-code -y ;  gcloud components update '
alias AGP2=' sudo apt-get purge -y ; dpkg -l | grep "^rc" | awk "{print\$2}" | xargs sudo apt-get purge -y ; sudo apt-get autoremove -y '
alias AGU=' sudo apt-get purge -y >/dev/null '
alias AGR=' sudo apt-get remove -y >/dev/null '
alias AGG=' sudo apt-get update >/dev/null ; apt list |tee ~/.APT |grep -i --color '
alias AGI=' sudo apt-get update >/dev/null ; sudo apt-get install -y >/dev/null '
#alias ACL2='sudo chown -R e:g /g && sudo chmod -R u+rwX,g+rwX,o-rwx /g && sudo chmod -R g+s /g && sudo setfacl -R -m u::rwx,g::rwx,o::-,m::rwx,d:u::rwx,d:g::rwx,d:o::-,d:m::rwx /g'
ACL() { sudo chown -R e:g /g & sudo chmod -R u+rwX,g+rwX,o-rwx,g+s /g & wait && sudo setfacl -R -m u::rwx,g::rwx,o::-,m::rwx,d:u::rwx,d:g::rwx,d:o::-,d:m::rwx /g; }
#alias ACL=' sudo chown -R :g /g ; sudo chmod -R 2777 /g ; sudo setfacl -R -m u::rwx,g::rwx,o::rwx,m:rwx,d:u::rwx,d:g::rwx,d:o::rwx,d:m:rwx /g '
#alias ACL=' sudo chown -R e:g /g ; sudo chmod -R 2777 /g ; sudo setfacl -R -m u::rwx,g::rwx,o::rwx,m:rwx,d:u::rwx,d:g::rwx,d:o::rwx,d:m:rwx /g '
alias llll=' sudo find . '
alias llllg=' sudo find . |grep -i '
alias tmprm=' sudo rm -rf /tmp/{,.}* 2>/dev/null ; cd /tmp '
alias SU=' sudo su - '
alias SUF=' sudo su - f '
alias SUN=' sudo su - n '
alias SUO=' sudo su - o '
alias SYSD=' sudo systemctl disable '
alias SYSE=' sudo systemctl enable '
alias SYSR=' sudo systemctl restart '
alias SYSS=' sudo systemctl stop '
alias SVH=' sudo vim /mnt/c/Windows/System32/drivers/etc/hosts '
alias YI=' sudo yum install -y >/dev/null '
alias LIST=' sudo yum list >~/.YUM &>/dev/null || apt-get update 1>/dev/null ; apt-get list > ~/.APT 1>/dev/null '
alias YG=' sudo yum list |tee ~/.YUM |grep -i --color '
alias YU=' sudo yum remove -y >/dev/null '
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
alias NVS=' watch nvidia-smi '
alias VGP='cd ~/.G/dotfiles ; git pull >/dev/null ; vim ~/.G/dotfiles/home/GEMINI.md ; git rm -r --cached . >/dev/null ; git add -A && git commit -amVGP &> /dev/null && git push 1>/dev/null ; cd - &>/dev/null'
#CBG() { curl  --connect-timeout 2 -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/home/.bash_profile |grep -i --color $1 2>/dev/null || cat ~/.bash_profile 2>/dev/null |grep -i --color $1 ; }
CBG() { curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/home/.bash_profile  |grep -i --color $1 2>/dev/null || cat  ~/.G/dotfiles/home/.bash_profile 2>/dev/null || cat ~/.bash_profile 2>/dev/null |grep -i --color $1 ; }
WATCH() { watch "$@" ; }
DIG() { echo "dig $1 |grep -vE ^\;\|^$" ; dig $1 | grep -vE ^\;\|^$ ; }
lgc() { cat $(ls -Ah |grep -i $1 ) || ls -Ah | grep -i $i ; }
lgcd() { cd $(ls -Ah |grep -i $1 ) || ls -Ah | grep -i $i ; }
lgv() { vim $(ls -Ah |grep -i $1 ) || ls -Ah | grep -i $i ; }
NUP() { useradd $1 -ms/bin/bash && echo "$1:$1" | chpasswd ; }
mkdirc() { mkdir $1 ; cd $1 ; }
WHOIS() { whois $1 | grep -Ev "^\s*(#|$)" |grep -i NetName ; }
AWK() { awk $2 "{print\$$1}" ; }
ECDZ() { echo 'source /dev/stdin <<< $(curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/home/.bash_profile)' |tee ~/.bash_profile ; }
l() { ls -A | grep "^\." | xargs -d '\n' ls -d --color ; }
NSP() { nmap -T5 -snP $1 |G report | AWK 5 ; }
DF() { df -h |sort -hk2 |sed -e 1b -e '$!d' ; }
SEDID() { sed -i "/$1/d" $2 ; }
SEDIS() { sed -i "s/$1/$2/g" $3 ; }
MTK() { mkdir ./$1 ; touch ./$1/.gitkeep; }
NTPL() { growpart /dev/sda 2 ; resize2fs /dev/sda2 ; echo 'network: {config: disabled}' >> /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg ; sed -i "s/\(- \).*\(\/\)/\1$1\2/g" /etc/netplan/50-cloud-init.yaml ; echo "hostnamectl set-hostname" ; }
GGRCA2() { (cd /g; for R in */; do [[ -d "$R/.git" ]] || continue; (U=$(git -C "$R" remote get-url origin) && sudo rm -rf "$R" && git clone -q "$U" "$R") & done; wait); }
GGRCA() { (cd /g; for R in */; do [[ -d "$R/.git" ]] || continue; (cd "$R"; git fetch -p && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD) && git clean -fd) & done; wait); }
CPTM() { rm /mnt/c/Users/e/Desktop/_tmp/* ; cp *.txt *.md *.py /mnt/c/Users/e/Desktop/_tmp/ ; }
sl() { for SOMETHING in $(cat ./$1); do $2 $SOMETHING; done; }
GRC2() { local T=$(git rev-parse --show-toplevel 2>/dev/null) || return 1; local U=$(git -C "$T" remote get-url origin) || return 1; local R=$(basename "$T"); local P="${PWD#$T}"; cd "$(dirname "$T")" && sudo rm -rf "$R" && git clone "$U" "$R" && cd "$R$P"; }
DUAL() { UV_PROJECT_ENVIRONMENT=/g/.TMP/dual-venv UV_CACHE_DIR=/g/.TMP/uv-cache XDG_CACHE_HOME=/g/.TMP/xdg-cache uv run --project /g/app/dual --with-editable /g/app/dual --directory "$PWD" python -m dual --config /g/app/dual/dual.toml "$@"; }
LG2() { local lg2_root=/g/app/lg2; [ -d "$lg2_root" ] || lg2_root=/g/app/lG; UV_PROJECT_ENVIRONMENT=/g/.TMP/lg2-venv UV_CACHE_DIR=/g/.TMP/uv-cache XDG_CACHE_HOME=/g/.TMP/xdg-cache TMPDIR=/g/.TMP/tmp UV_VENV_CLEAR=0 uv run --project "$lg2_root" --directory "$PWD" lg2-run --config "$lg2_root/lg2.toml" "$@"; }
#LG3() { local lg3_root=/g/app/lg3; UV_PROJECT_ENVIRONMENT=/g/.TMP/lg3-venv UV_CACHE_DIR=/g/.TMP/uv-cache XDG_CACHE_HOME=/g/.TMP/xdg-cache TMPDIR=/g/.TMP/tmp UV_VENV_CLEAR=0 uv run --project "$lg3_root" --directory "$PWD" LG3 "$@"; }
#LG4() { local lg4_root=/g/app/lg4; UV_PROJECT_ENVIRONMENT=/g/.TMP/lg4-venv UV_CACHE_DIR=/g/.TMP/uv-cache XDG_CACHE_HOME=/g/.TMP/xdg-cache TMPDIR=/g/.TMP/tmp UV_VENV_CLEAR=0 uv run --project "$lg4_root" --directory "$PWD" LG4 "$@"; }
CIO() { if [ -n "$1" ]; then cp -urf "$1" /mnt/c/Users/e/Desktop/; else cp -urf ./* /mnt/c/Users/e/Desktop/; fi; }
COI() { if [ -n "$1" ]; then cp -urf "/mnt/c/Users/e/Downloads/$1" .; else cp -urf /mnt/c/Users/e/Downloads/* .; fi; }
UR() { if [ -n "$1" ]; then uv run --no-project "$@"; else uv run --no-project main.py; fi; }
GRCD() { local _old="$PWD"; cd ~/.G/dotfiles && git fetch --prune && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD) && git clean -fd; cd "$_old"; }
CMPL() { $1 completion bash > /etc/bash_completion.d/$1 || ls -l /etc/bash_completion.d ; }
PING() { for i in $(seq 0 255) ; do ping $1.$i -c1 -W1 & done |grep from |awk '{print $4}' |awk -F: '{print $1}' | sort -V ; }
FFMPEG1() { for i in *.$1 ; do ffmpeg -y -i "$i" "$(echo "$i"|cut -d\. -f1).$2" & done ; }
FFMPEG() { for i in *.$1 ; do ffmpeg -y -i "$i" "$(echo "$i"|cut -d\. -f1).$2" ; done ; }
WAIT() { while pgrep -f "$1" > /dev/null; do sleep 9; done ; }
KILL() { sudo pkill -fi "$1"; }
PUSHM() { git pull >/dev/null ; git rm -r --cached . > /dev/null ; git add -A && git commit -m "$@" &>/dev/null && git push;}
CB2() { cat ~/.G/dotfiles/home/.bash_profile 2>/dev/null || curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/home/.bash_profile ; }
CNG() { cat ~/.G/misc/notes/commands.txt 2>/dev/null |grep -i --color $1 || curl -fsSL https://raw.githubusercontent.com/ernie18a/misc/main/notes/commands.txt |grep -i --color $1 ; }
CEG() { cat ~/.G/misc/notes/eng.txt 2>/dev/null |grep -i --color $1 || curl -fsSL https://raw.githubusercontent.com/ernie18a/misc/main/notes/eng.txt |grep -i --color $1 ; }
CP() { cat ~/.G/private/yet/RANDOM.txt ; }
GRCA2() { (cd ~/.G; for R in */; do (U=$(git -C "$R" remote get-url origin) && sudo rm -rf "$R" && git clone -q "$U" "$R") & done; wait); }
GRCA()  { (cd ~/.G; for R in */; do (cd "$R"; git fetch -p && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD) && git clean -fd) & done; wait); }
CT() { cat ~/.T$1 2>/dev/null ; }
VT() { vim ~/.T$1 ; }
HG() { cat ~/.bash_history | grep -ai --color "$1" ; }
CG() { cat ~/.gemini/GEMINI.md 2>/dev/null || curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/home/GEMINI.md ; }
# USAGE() { date ; sudo -i bash -lc 'cd /g/app/usage && uv run main.py' ; }
USAGE() { date; sudo -i bash -lc 'cd /g/app/usage && uv run main.py' 2>/dev/null; }

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/home/e/google-cloud-sdk/path.bash.inc' ]; then . '/home/e/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/home/e/google-cloud-sdk/completion.bash.inc' ]; then . '/home/e/google-cloud-sdk/completion.bash.inc'; fi
mvim() { mkdir -p "$(dirname "$1")" && vim "$1"; }
