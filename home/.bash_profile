complete -C '/usr/local/bin/aws_completer' aws &>/dev/null
complete -C /usr/bin/terraform terraform
source /etc/bash_completion.d/* 2>/dev/null
source /usr/share/bash-completion/bash_completion 2>/dev/null
export COLORTERM=truecolor
export CUDA_CACHE_MAXSIZE=2147483647
export CUDA_CACHE_PATH=/tmp/.cuda_cache
export CUDA_DEVICE_MAX_CONNECTIONS=32
export CUDA_LAUNCH_BLOCKING=1
export CUDA_MANAGED_FORCE_DEVICE_ALLOC=1
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
export MAILCHECK=0 &>/dev/null
export NVM_DIR="$HOME/.nvm"
export OLLAMA_API_BASE=http://127.0.0.1:11434
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/snap/bin:/opt/homebrew/bin:$HOME/.docker/cli-plugins:$HOME/bin"
export TERM=xterm-256color
export UV_VENV_CLEAR=1
export WIN_USER=`ls /mnt/c/Users 2>/dev/null |grep -iv "All\|Default\|desktop.ini\|Public\|USER\|Administrator\|super"`
export WIN_USER_DIR=/mnt/c/Users/$WIN_USER
which git &>/dev/null && export PS1="[ \\u@\\h \w \$(git rev-parse --abbrev-ref HEAD 2>/dev/null)] \\$ " || export PS1="[ \\u@\\h \w ] \\$ "
PROMPT_COMMAND=' history -a '
source ~/.55H 2>/dev/null
source ~/.IPS 2>/dev/null
touch ~/.hushlogin
alias MM2=' DEV=$(blkid -L g) && mountpoint -q /g || sudo mount -o defaults,noatime,commit=300 $DEV /g '
alias CDA=' cd /g/private/app/ ; ls -l --color '
alias CDN=' cd /g/private/nf/ ; ls -l --color '
alias MM=" DEV=\$(blkid -L g) && mountpoint -q /g || sudo mount -o defaults,noatime,commit=300 \$DEV /g "
alias UU=' [ "$(npm view npm version)" != "$(npm -v)" ] && sudo npm install -g npm ; [ "$(npm view @google/gemini-cli version)" != "$(gemini --version 2>/dev/null)" ] && sudo npm install -g @google/gemini-cli ; claude upgrade '
alias UG=' [ "$(npm view npm version)" != "$(npm -v)" ] && sudo npm install -g npm ; [ "$(npm view @google/gemini-cli version)" != "$(gemini --version 2>/dev/null)" ] && sudo npm install -g @google/gemini-cli ; gemini '
alias AGP='sudo apt-get purge -y "$@" && dpkg -l | grep "^rc" | awk "{print \$2}" | xargs -r sudo apt-get purge -y && sudo apt-get autoremove --purge -y && sudo apt-get clean'
alias APT=' bash -c "curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/i.apt.sh" | bash -s -- '
alias bcl=' bat -ppl '
alias bcb=' bat -ppl bash '
alias bcjs=' bat -ppl js '
alias bcm=' bat -ppl md '
alias MD=' bat -ppl md *.md '
alias BR=' bat -ppl md README.md '
alias bcmr=' bat -ppl md README.md '
alias bcp=' bat -ppl py '
alias bcr=' bat -ppl rb '
alias CL=' claude --model sonnet --dangerously-skip-permissions '
alias CLR=' claude --model sonnet --dangerously-skip-permissions --resume '
alias ACL=' sudo setfacl -R -b /g ; sudo setfacl -R -m u::rwx,g::rwx,o::rwx,m:rwx /g ; sudo setfacl -R -d -m u::rwx,g::rwx,o::rwx,m:rwx /g ; sudo chattr -R -i -a /g 2>/dev/null || true '
alias CLH=' claude --model haiku --dangerously-skip-permissions '
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
alias CSG=' cat ~/.ssh/config | grep -i --color '
alias CDW=' cd $WIN_USER_DIR '
alias CDWE=' cd $WIN_USER_DIR/Desktop ; ls -l --color '
alias CDWT=' cd $WIN_USER_DIR/Desktop/_tmp ; ls -l --color '
alias CDWO=' cd $WIN_USER_DIR/Downloads ; ls -l --color '
alias ..=' cd ../ '
alias ...=' cd ../../ '
alias ....=' cd ../../../ '
alias .....=' cd ../../../../ '
alias ......=' cd ../../../../../ '
alias VPP=' cd ~/.G/private/yet ; git pull >/dev/null ; vim ./RANDOM.txt; git rm -r --cached . > /dev/null ; git add -A && git commit -amVPP &> /dev/null && git push ; cd - &>/dev/null '
alias VBP=' cd ~/.G/dotfiles ; git pull >/dev/null ; vim ~/.G/dotfiles/home/.bash_profile ; git rm -r --cached . >/dev/null ; git add -A && git commit -amVBP &> /dev/null && git push 1>/dev/null ; cd - &>/dev/null '
alias CDD=' cd ~/.G/dotfiles ; ls -l --color '
alias CDP=' cd ~/.G/private ; ls -l --color '
alias VNP=' cd ~/.G/misc/notes ; git pull >/dev/null ; vim ./commands.txt ; git rm -r --cached . > /dev/null ; git add -A && git commit -amVNP &> /dev/null && git push ; cd - &>/dev/null '
alias VEP=' cd ~/.G/misc/notes ; git pull >/dev/null ; vim ./eng.txt ; git rm -r --cached . > /dev/null ; git add -A && git commit -amVEP &> /dev/null && git push ; cd - &>/dev/null '
alias co=' cp '
alias cp=' cp -urf '
alias CPWE=' cp ./$1 $WIN_USER_DIR/Desktop/ '
alias BNA=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/e.brc.n.auth.sh | bash '
alias COLAB=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/e.colab.sh | bash '
alias CDZ=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/e.danger.zone.sh | bash '
alias ED2=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/e.ed25519.sh | bash '
alias CGI=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/e.gemini.api.sh | bash '
alias CMTZ=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/e.git.reset.sh | bash '
alias NBP=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/e.new_bash_profile.sh | bash '
alias PIP=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/e.pip.sh | bash '
alias VIMRC=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/e.vimrc.sh | bash '
alias AWS=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/i.aws-cli.sh | bash '
alias BAT=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/i.bat.sh | bash '
alias GEMINI=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/i.gemini.sh | bash '
alias GOLANG=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/i.golang.sh | bash '
alias IPP=' curl ipinfo.io ; curl ifconfig.io '
alias DET=' deactivate '
alias DU=' du -sh . ; du -hd1 2>/dev/null |grep "G\|M" '
alias DY=' echo -e "\nflexibility to improve adaptability\n" '
alias GRC3='git fetch --prune && git rm -r --cached . && git reset --hard && git clean -fd && git pull'
alias FINDD=' find . -iname 2>/dev/null '
alias FIND=' find / -iname 2>/dev/null '
alias GG=' gemini '
alias GGR=' gemini --resume '
alias GY=' gemini -y '
alias GCO=' git checkout '
alias GC=' git clone '
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
alias ll=' ls -l --color '
alias llh=' ls -lh --color '
alias CDB=' mkdir ~/.BACKUP &>/dev/null ; cd ~/.BACKUP ; ls -A --color |sort '
alias CDG=' mkdir ~/.G &>/dev/null ; cd ~/.G/* 2>/dev/null || { cd ~/.G && ls -A --color |sort ; } '
alias NC=' nc -zvw2 '
alias PS5=' ps aux | sort -nrk 3,3 | head -n 5 '
alias PUSH="git pull >/dev/null && git add -A && git commit -mPUSH --no-verify && git push --no-verify"
alias PY=' python3 '
alias rm=' rm -rf '
alias RSYNC=' rsync -ruzvP '
alias scpr=' scp -rC '
alias SHK=' sort -hk '
alias SB=' source ~/.G/dotfiles/home/.bash_profile 2>/dev/null || source /dev/stdin <<< "$(curl -Ls https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile)" ; cd - &>/dev/null '
alias SS=' ss -lutn '
alias SSG=' ss -lutn |grep -i --color '
alias AGP2=' sudo apt-get purge -y ; dpkg -l | grep "^rc" | awk "{print\$2}" | xargs sudo apt-get purge -y ; sudo apt-get autoremove -y '
alias AGU=' sudo apt-get purge -y >/dev/null '
alias AGR=' sudo apt-get remove -y >/dev/null '
alias AGG=' sudo apt-get update >/dev/null ; apt list |tee ~/.APT |grep -i --color '
alias AGI=' sudo apt-get update >/dev/null ; sudo apt-get install -y >/dev/null '
alias llll=' sudo find . '
alias llllg=' sudo find . |grep -i '
alias NPMG=' sudo npm install -g npm ; sudo npm install -g @google/gemini-cli '
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
CBG() { curl  --connect-timeout 2 -Ls https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile |grep -i --color $1 2>/dev/null || cat ~/.bash_profile 2>/dev/null |grep -i --color $1 ; }
WATCH() { watch "$@" ; }
DIG() { echo "dig $1 |grep -vE ^\;\|^$" ; dig $1 | grep -vE ^\;\|^$ ; }
lgc() { cat $(ls -Ah |grep -i $1 ) || ls -Ah | grep -i $i ; }
lgcd() { cd $(ls -Ah |grep -i $1 ) || ls -Ah | grep -i $i ; }
lgv() { vim $(ls -Ah |grep -i $1 ) || ls -Ah | grep -i $i ; }
NUP() { useradd $1 -ms/bin/bash && echo "$1:$1" | chpasswd ; }
mkdirc() { mkdir $1 ; cd $1 ; }
WHOIS() { whois $1 | grep -Ev "^\s*(#|$)" |grep -i NetName ; }
AWK() { awk $2 "{print\$$1}" ; }
ECDZ() { echo 'source /dev/stdin <<< "$(curl -Ls https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile)"' |tee ~/.bash_profile /home/e/.bash_profile /home/ubuntu/.bash_profile ; }
#YTDLA() { yt-dlp --js-runtimes node -f "ba/b" -x --no-check-certificate -i -a "$1"; }
#YTDLA2() { yt-dlp --js-runtimes node -f "ba/w" -x --no-check-certificate -i --audio-format wav --postprocessor-args "ffmpeg:-ac 1 -ar 16000" --no-warnings -a "$1" ; }
#YTDLV() { yt-dlp --js-runtimes node -i --no-check-certificate -a "$1"; }
l() { ls -A | grep "^\." | xargs -d '\n' ls -d --color ; }
BRC() { curl -Ls https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile |grep -vEi raw.githubusercontent.com\|git_ps1 | ssh $1 "cat > .BRC" ; }
NSP() { nmap -T5 -snP $1 |G report | AWK 5 ; }
DF() { df -h |sort -hk2 |sed -e 1b -e '$!d' ; }
SEDID() { sed -i "/$1/d" $2 ; }
SEDIS() { sed -i "s/$1/$2/g" $3 ; }
MTK() { mkdir ./$1 ; touch ./$1/.gitkeep; }
NTPL() { growpart /dev/sda 2 ; resize2fs /dev/sda2 ; echo 'network: {config: disabled}' >> /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg ; sed -i "s/\(- \).*\(\/\)/\1$1\2/g" /etc/netplan/50-cloud-init.yaml ; echo "hostnamectl set-hostname" ; }
GGRCA2() { (cd /g; for R in */; do [[ -d "$R/.git" ]] || continue; (U=$(git -C "$R" remote get-url origin) && rm -rf "$R" && git clone -q "$U" "$R") & done; wait); }
CPTM() { rm /mnt/c/Users/e/Desktop/_tmp/* ; cp *.txt *.md *.py /mnt/c/Users/e/Desktop/_tmp/ ; }
sl() { for SOMETHING in $(cat ./$1); do $2 $SOMETHING; done; }
GRC2() { local T=$(git rev-parse --show-toplevel 2>/dev/null) || return 1; local U=$(git -C "$T" remote get-url origin) || return 1; local R=$(basename "$T"); local P="${PWD#$T}"; cd "$(dirname "$T")" && rm -rf "$R" && git clone "$U" "$R" && cd "$R$P"; }
CIO() { if [ -n "$1" ]; then cp -urf "$1" /mnt/c/Users/e/Desktop/; else cp -urf ./* /mnt/c/Users/e/Desktop/; fi; }
COI() { if [ -n "$1" ]; then cp -urf "/mnt/c/Users/e/Downloads/$1" .; else cp -urf /mnt/c/Users/e/Downloads/* .; fi; }
CMPL() { $1 completion bash > /etc/bash_completion.d/$1 || ls -l /etc/bash_completion.d ; }
PING() { for i in $(seq 0 255) ; do ping $1.$i -c1 -W1 & done |grep from |awk '{print $4}' |awk -F: '{print $1}' | sort -V ; }
FFMPEG1() { for i in *.$1 ; do ffmpeg -y -i "$i" "$(echo "$i"|cut -d\. -f1).$2" & done ; }
FFMPEG() { for i in *.$1 ; do ffmpeg -y -i "$i" "$(echo "$i"|cut -d\. -f1).$2" ; done ; }
PUSHM() { git pull >/dev/null ; git rm -r --cached . > /dev/null ; git add -A && git commit -m "$@" &>/dev/null && git push;}
CNG() { cat ~/.G/misc/notes/commands.txt 2>/dev/null |grep -i --color $1 || curl -fsSL https://raw.githubusercontent.com/ernie18a/misc/main/notes/commands.txt |grep -i --color $1 ; }
CEG() { cat ~/.G/misc/notes/eng.txt 2>/dev/null |grep -i --color $1 || curl -fsSL https://raw.githubusercontent.com/ernie18a/misc/main/notes/eng.txt |grep -i --color $1 ; }
GRCA2() { (cd ~/.G; for R in */; do (U=$(git -C "$R" remote get-url origin) && rm -rf "$R" && git clone -q "$U" "$R") & done; wait); }
GGRCA3() { (cd /g; for R in */; do [[ -d "$R/.git" ]] || continue; (cd "$R"; git fetch -p && git rm -r --cached . && git reset --hard && git clean -fd && git pull) & done; wait); }
GRCA3()  { (cd ~/.G; for R in */; do (cd "$R"; git fetch -p && git rm -r --cached . && git reset --hard && git clean -fd && git pull) & done; wait); }
CT() { cat ~/.T$1 2>/dev/null ; }
VT() { vim ~/.T$1 ; }
HG() { cat ~/.bash_history | grep -ai --color "$1" ; }
CB2() { cat ~/.G/dotfiles/home/.bash_profile 2>/dev/null || curl -Ls https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile ; }
CP() { cat ~/.G/private/yet/RANDOM.txt ; }
CG() { cat ~/.gemini/GEMINI.md 2>/dev/null || curl -Ls https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/GEMINI.md ; }
GGRCA() { (cd /g; for R in */; do [[ -d "$R/.git" ]] || continue; (cd "$R"; git fetch -p && git reset --hard && git clean -fd && git pull) & done; wait); }
GRCA()  { (cd ~/.G; for R in */; do (cd "$R"; git fetch -p && git reset --hard && git clean -fd && git pull) & done; wait); }
alias GRC='git fetch --prune && git reset --hard && git clean -fd && git pull'
UR() { if [ -n "$1" ]; then uv run "$1"; else uv run main.py; fi; }
GRCD() { local _old="$PWD"; cd ~/.G/dotfiles && git fetch --prune && git reset --hard && git clean -fd && git pull; cd "$_old"; }
KILL() { sudo pkill -fi "$1"; }
