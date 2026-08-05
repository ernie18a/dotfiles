
# 
# AWK() { awk "{print\$$1}" ; }
# BB() { kubectl delete pod ernie-busybox 2>/dev/null ; kubectl run -it ernie-busybox --image=busybox --rm -- $1 ; }
# BRC() { ssh-copy-id $i && (cat ~/.ssh/authorized_keys | grep -qE "e@mac|123@tgfc" || cat ~/.ssh/id_rsa.pub | ssh $i 'cat >> ~/.ssh/authorized_keys') && curl -Ls https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/.bash_profile | grep -vEi raw.githubusercontent.com\|git_ps1 | ssh $i "cat > .BRC" ; }
# BRCL() { curl -Ls https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/.bash_profile |grep -vEi raw.githubusercontent.com\|git_ps1 | ssh $1 "cat > .BRC" ; }
# BUBH() { cd ~/.G/private/ ; git fetch --prune ; git reset --hard ; git clean -f ; git pull ; cat ~/.bash_history >> ~/.G/private/.bash_history ; cat .bash_history  | tr -s ' ' | sed -e 's/\r//g' -e 's/\t/ /g' -e 's/\x1B\[[0-9;]*[a-zA-Z]//g' |   sed 's/[[:space:]]*$//' | sort | uniq  | tee .bash_history >/dev/null ; git rm -r --cached . > /dev/null ; git add -A ; git commit -m backup &>/dev/null ; git push ; cd - ; } 
# CBG() { cat ~/.bash_profile 2>/dev/null |grep -i --color $1 || curl -Ls https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/.bash_profile |grep -i --color $1 ; }
# CBG() { curl -Ls https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/.bash_profile |grep -i --color $1 2>/dev/null || cat ~/.bash_profile 2>/dev/null |grep -i --color $1 ; }
# CGC() { grep -iR --color $1 ~/.G/dotfiles/curl ; }
# CGM() { grep -iR --color $1 ~/.G/misc/deploying ; }
# CMPL() { ls /etc/bash_completion.d && $1 completion bash > /etc/bash_completion.d/$1 ; }
# CNG() { cat ~/.G/misc/notes/commands.txt 2>/dev/null |grep -i --color $1 || curl -fsSL https://gitlab.com/ernie18a/misc/-/raw/master/notes/commands.txt |grep -i --color $1 ; }
# CURL() { while true ; do curl -sS $1?$(date +%s) ; echo -n $(date +%H:%M:%S.%N)\ ; done ; }
# DLI() { docker login -u $(cat .docker/config.json |G auth.*== |AWK 2 |tr '"' ' ' |AWK 1 |base64 -d |AWK 1 -F:) -p $(cat .docker/config.json |G auth.*== |AWK 2 |tr '"' ' ' |AWK 1 |base64 -d |AWK 2 -F:) }
# DOCKERBTP() { docker build . -t $2 ; docker tag $2 ernie18a/$1:$2 ; docker push ernie18a/$1:$2 ; }
# DOCKERTP() { docker tag $2 ernie18a/$1:$2 ; docker push ernie18a/$1:$2 ; }
# DRUN() { docker run -h $1 --name $1 -itd $1 ; } # might be failed if $1 is abc.io/nginx
# ECDZ() { echo ' source /dev/stdin <<< "$(curl -Ls https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/.bash_profile)" ' > ~/.bash_profile ; }
# FPG() { find "$(pwd)" | grep -i --color $1 ; }
# GDO() { curl -s https://api.github.com/repos/$1/$2/releases/latest |grep browser_download_url |grep linux.$(uname -m)\" |awk "{print\$2}" |xargs wget -O /bin/$3 ; chmod 0755 /bin/$3 ; }
# GGRCA() { (cd /g; for R in */; do [[ -d "$R/.git" ]] || continue; (cd "$R"; { git fetch -p && git rm --ignore-unmatch -r . --cached && git checkout -fB main origin/main && git clean -fdx; } > /dev/null) & done; wait); }
# GRC2() { local T=$(git rev-parse --show-toplevel 2>/dev/null) || return 1; local U=$(git -C "$T" config --get remote.origin.url) || return 1; local R=$(basename "$T"); local P="${PWD#$T}"; cd "$(dirname "$T")" && rm -rf "$R" && git clone "$U" "$R" && cd "$R$P"; }
# GRCA() { (cd ~/.G || return 1; for R in */; do (cd "$R" && [ -d .git ] || exit 0; OUT=$({ git fetch -p origin && BR=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'); BR=${BR:-main}; git checkout -fB "$BR" "origin/$BR"; } 2>&1); [ -n "$OUT" ] && printf "[%s] %s\n" "${R%/}" "$OUT") & done; wait); }
# GRCA() { (cd ~/.G || return 1; for REPO in */ ; do (cd "$REPO" && git fetch --all --prune && git checkout -B main origin/main && git clean -fd) & done; wait); }
# GRCA() { (cd ~/.G; for R in */; do (cd "$R"; { git fetch -p && git rm --ignore-unmatch -r . --cached && git checkout -fB main origin/main && git clean -fdx; } > /dev/null) & done; wait); }
# GRCA() { cd ~/.G ; for REPO in `ls`; do (cd "$REPO"; git fetch --prune && git reset --hard && git clean -fd && git pull > /dev/null ; git reset --hard ; git pull ); done; cd - ; }
# GRCA() { cd ~/.G ; for REPO in `ls`; do (cd "$REPO"; git fetch --prune ; git reset --hard && git clean -f -d ; git rm -r . --cached . > /dev/null ; git reset --hard ; git pull ); done; cd - ; }
# GRCA2() { (cd ~/.G || return 1; for R in */; do (cd "$R" && OUT=$({ git fetch -p && git checkout -fB main origin/main && git clean -fd; } 2>&1) && printf "%s\n" "$OUT" | sed "s/^/[${R%/}] /") & done; wait); }
# GRCA2() { (cd ~/.G || return 1; for R in */; do (cd "$R" && [ -d .git ] || exit 0; OUT=$({ git fetch -p && BR=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo main) && git checkout -fB "$BR" "origin/$BR"; } 2>&1); [ -n "$OUT" ] && printf "%s\n" "$OUT" | sed "s/^/[${R%/}] /") & done; wait); }
# GRCA2() { (cd ~/.G || return 1; for REPO in */ ; do (cd "$REPO" && OUT=$({ git fetch --all --prune && git reset --hard origin/main && git clean -fd; } 2>&1) && printf "%s\n" "$OUT" | sed "s/^/[${REPO%/}] /") & done; wait); }
# GRCA2() { (cd ~/.G || return 1; for REPO in */ ; do (cd "$REPO" && git fetch --all --prune && git reset --hard @{u} && git clean -fd) & done; wait); }
# GRCA2() { (cd ~/.G; for R in */; do (U=$(git -C "$R" remote get-url origin) && rm -rf "$R" && git clone -q "$U" "$R") & done; wait); }
# GRCA2() { cp -a ~/.G /tmp/G_backup_$(date +%s) && for d in ~/.G/*/; do u=$(awk -F'= ' '/url/ {print $2; exit}' "${d}.git/config" 2>/dev/null); [ -n "$u" ] && rm -rf "$d" && git clone "$u" "$d"; done ; }
# GRCA3() { (cd ~/.G || return 1; for R in */; do (cd "$R" && OUT=$({ git fetch -p && git checkout -fB main origin/main && git clean -fdx; } 2>&1) && printf "%s\n" "$OUT" | sed "s/^/[${R%/}] /") & done; wait); }
# GRCA3() { rm -rf /tmp/.G && cp -a ~/.G /tmp/ && for d in ~/.G/*/; do ([ -d "${d}.git" ] && git -C "$d" fetch -p -q && br=$(git -C "$d" branch --show-current) && git -C "$d" reset --hard "origin/${br:-main}" -q && git -C "$d" clean -fd -q) & done; wait ; }
# GRSED() { grep -lR $1 . | xargs sed $3 "s/$1/$2/g" ; }
# GUA() { for REPO in `ls`; do (cd "$REPO"; git fetch --prune ; git reset --hard && git clean -f -d ; git rm -r --cached . > /dev/null ; git reset --hard ; git pull ); done; }
# GV() { grep -Ev "^\s*(#|$)" ; }
# GV() { grep -Ev '^\s*(#|$)' ; }
# GV() { grep -v ^\ *$ |grep -v ^\ *# |grep -v ^\t*$ |grep -v ^\t*# |grep -v ^$'\r' | grep -vP ^'\t*#' ; }
# GV2() { grep -PEv ^\ *$\|^\ *#\|^\t*$\|^\t*#\|^$'\r'\|^'\t*#' ; }
# GV2() { grep -Pv '^\s*$|^\s*#|^\t*$|^\t*#|^$'\r'|^\t*#' ; }
# GV3() { grep -v '^[[:space:]]*$\|^[[:space:]]*#' | grep -v '^[[:space:]]*$' | grep -v $'\r' ; }
# HI() { a=$(echo -n $1 |awk -F/ "{print\$2}") ; helm install $a $1 ; } # cannot apply ns?
# HI() { helm install $(echo -n $1 |AWK 2 -F/) $1 -n $2 || helm install $(echo -n $1 |AWK 2 -F/) $1 ; }
# HLA() { helm ls -A |awk '{print $1"\t"$2}' ; }
# HRM() { sed -i "/$1/d" ~/.bash_history ; }
# KD() { kubectl describe $2 -n $1 2>/dev/null || kubectl describe $1 2>/dev/null ; }
# KEI() { kubectl exec -it $1 -- $2 2>/dev/null ; }
# KGAG() { kubectl get -A $1 | grep -i --color $2 ; }
# KGPC() { kubectl get pods $1 -o jsonpath="{.spec.containers[*].name}" 2>/dev/null | tr " " "\n" ; }
# KGPN() { kubectl get po $1 -n $(kubectl get po -A | grep $1 | awk "{print\$1}") ; }
# KGR() { kubectl get rc,$1 ; }
# KIN() { kubectl exec $1 -- bash -c "apt update ; apt install -y dnsutils watch curl iputils-ping iproute2 nmap vim lsof apt-file telnet ; curl -fsSl https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/.bash_profile -o ~/.bashrc " ; }
# KL() { kubectl logs $1 -n $2 --all-containers 2>/dev/null || kubectl logs $1 --all-containers ; }
# KL() { kubectl logs $1 -n $2 --all-containers || kubectl logs $1 --all-containers ; }
# KL() { kubectl logs $2 -n $1 2>/dev/null || kubectl logs $1 2>/dev/null ; }
# NTPL() { growpart /dev/sda 2 ; resize2fs /dev/sda2 ; echo 'network: {config: disabled}' >> /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg ; hostnamectl set-hostname u$(echo $1 |awk -F. "{print\$4}") ; sed -i "s/\(- \).*\(\/\)/\1$1\2/g" /etc/netplan/50-cloud-init.yaml ; }
# NTPL() { growpart /dev/sda 2 ; resize2fs /dev/sda2 ; hostnamectl set-hostname u$(echo $1 |awk -F. "{print\$4}") ; echo /etc/netplan/00-installer-config.yaml ; }
# NTPL() { growpart /dev/sda 2 ; resize2fs /dev/sda2 ; hostnamectl set-hostname u$(echo $1 |awk -F. "{print\$4}") ; sed -i "s/\(- \).*\(\/\)/\1$1\2/g" /etc/netplan/00-installer-config.yaml ; }
# NTPL() { growpart /dev/sda 2 ; resize2fs /dev/sda2 ; sed -i "/\//d" /etc/netplan/00-installer-config.yaml ; sed -i "/gateway4/i \ \ \ \ \ \ - $1/24" /etc/netplan/00-installer-config.yaml ; hostnamectl set-hostname u$(echo $1 |awk -F. "{print\$4}") ; }
# NTPL.ORIGINAL() { growpart /dev/sda 2 ; resize2fs /dev/sda2 ; sed -i "/\//d" /etc/netplan/00-installer-config.yaml ; sed -i "/gateway4/i \ \ \ \ \ \ - $1/24" /etc/netplan/00-installer-config.yaml ; hostnamectl set-hostname u$(echo $1 |awk -F. "{print\$4}") ; }
# SUL() { sudo updatedb ; sudo locate -i $1 | grep -i --color $1 ; }
# TEST4() { bash -c "curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.apt.sh | bash -s \"$@\"" ; } # https://gemini.google.com/app/541a8f0e276347f3
# UA() { useradd $1 -ms/bin/bash ; echo -e "$2\n$2" | passwd $1 ; }
# YTDL1() { while read i ; do yt-dlp --prefer-ffmpeg --extract-audio --audio-format mp3 --no-check-certificate "$i" ; done <$1 ; }
# YTDLA() { yt-dlp --js-runtimes node -x --no-check-certificate -i -a "$1"; }
# YTDLA2() { yt-dlp --js-runtimes node -x --no-check-certificate -i --audio-format wav --postprocessor-args "ffmpeg:-ac 1 -ar 16000" -a "$1" ; }
# YTDLS() { yt-dlp --js-runtimes node --write-auto-subs --sub-langs en,eng --skip-download -i --no-check-certificate --convert-subs srt -a "$1"; } 
# YTDLV() { while read i ; do yt-dlp --no-check-certificate --write-auto-sub --sub-lang en "$i" ; done <$1 ; }
# YTDLV() { while read i ; do yt-dlp --no-check-certificate --write-auto-sub --sub-lang en --merge-output-format mp4 "$i" ; done <$1 ; }
# YTDLV() { while read i ; do yt-dlp -c -r 1k https://aiguides.com/advanced-chatgpt-prompts/  -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best "$i" ; done <$1 ; }
# YTDLXI() { while read i ; do yt-dlp -xi --no-check-certificate "$i" ; done <$1 ; }
# alias 2ALL=' M2G ; M24 ; P2P ; rm -rf *webm *webp '
# alias 8888=' ping 8.8.8.8 '
# alias AALH=' ansible all --list-hosts '
# alias AK=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/e.authorized_keys.sh | bash '
# alias AKE=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/e.authorized_keys.ed25519.sh | bash '
# alias ALPINE=' docker build -t alpine:ernie https://gitlab.com/ernie18a/misc/-/raw/master/deploying/Dockerfile.alpine 1>/dev/null ; echo -e "kubectl run --image=alpine:ernie alpine\nkubectl exec -it alpine -- bash\ndocker run -h alpine --name alpine -id alpine:ernie\ndocker exec -it alpine bash" '
# alias AMPERE=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.kube.ampere.sh | bash '
# alias AP=' ansible-playbook '
# alias APB=' ansible-playbook '
# alias APH=' ansible-playbook -i .hosts '
# alias APT=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.apt.sh | bash '
# alias AUTH=' cat ~/.ssh/authorized_keys '
# alias AUTH=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/e.authorizing.sh | bash '
# alias AWX=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.awx-operator.sh | bash '
# alias B6=' echo "$1" | base64 -d '
# alias BRCL=' echo source /dev/stdin <<< "$(curl -Ls https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/.bash_profile)" > ~/.BRC '
# alias C8=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.c8.sh | bash '
# alias CALICO=' kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml '
# alias CAPI=' grep -B1 "^\s*export" ~/.55H | grep ^# '
# alias CCAT=' sudo curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/.sbin/ccat -o /bin/ccat ; sudo chmod +x /bin/ccat '
# alias CD4=' cd ~/.G/411d3 && ls -A --color |sort   '
# alias CDA=' cd ~/.G/ac && ls -A --color |sort   '
# alias CDF=' cd ~/.G/411d3 ; ls -l --color '
# alias CDG=' cd ~/.G || mkdir ~/.G ; cd ~/.G ; ls -A --color |sort '
# alias CDG=' cd ~/.G/* 2>/dev/null || cd ~/.G '
# alias CDG=' cd ~/.G/* 2>/dev/null || mkdir ~/.G 2>/dev/null ; cd ~/.G ; ls -A --color '
# alias CDG=' cd ~/.G/* || cd ~/.G ; ls -A --color |sort '
# alias CDG=' cd ~/.G/* || mkdir ~/.G ; cd ~/.G ; ls -A --color |sort '
# alias CDGM=' cd ~/.G/misc/deploying ; ls -Al --color | sort '
# alias CDGP=' cd ~/.G/.awx-cathay-cicd 2>/dev/null || cd ~/.G/awx-cathay-cicd '
# alias CDI=' cd ~/.G/15 ; ls -l '
# alias CDM=' cd ~/.G/1v9/migrate ; ls -A --color |sort '
# alias CDN=' cd ~/.G/411d3/n* && ls -A --color |sort   '
# alias CDP' mkdir -p  ~/.G/private2/_tmp ; cd  ~/.G/private2/_tmp ; ls -l --color '
# alias CDP=' cd  ~/.G/private ; ls -l --color '
# alias CDP=' cd ~/.G/private ; ls -l --color '
# alias CDPP=' cd  ~/.G/private2 ; ls -l --color '
# alias CDPP=' cd ~/.G/private2/_prompt/ ; ls -l --color '
# alias CDQ=' cd /mnt/c/Users/e/AppData/Roaming/MetaQuotes/Terminal/0*/MQL5/Experts ; ls -A --color |sort '
# alias CDT=' cd /tmp ; ls -A --color |sort '
# alias CDT=' cd /tmp ; ls -Al --color | sort '
# alias CDT=' cd ~/.G/private/thoughts '
# alias CDWE=' cd /mnt/c/Users/coole/OneDrive/Desktop ; ls -l --color '
# alias CDWV=' cd $WIN_USER_DIR/vagrant '
# alias CEH=' cat /etc/hosts '
# alias CIO=' cp -urf ./* /mnt/c/Users/e/Desktop/ '
# alias CIY=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.yum.sh | bash '
# alias CKAR=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/.deprecated/i.kube.apt.reset.sh | bash '
# alias CKR2=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/_kube.reset.sh |bash '
# alias CKYM=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.kube.yum.m.sh | bash '
# alias CKYR=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.kube.yum.reset.sh | bash '
# alias CNG=' cat ~/.G/misc/notes/commands.txt | grep --color -i '
# alias COI=' cp -urf /mnt/c/Users/e/Downloads/* . '
# alias COLUMN=' apt-get install -y bsdmainutils || yum install -y util-linux '
# alias CONTAINERD=' curl -fssL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.containerd.sh | bash '
# alias CP=' cat ~/.G/private2/_data/RANDOM.txt 2>/dev/null '
# alias CV=' cat values.yaml '
# alias DAE=' ls -a ~ |grep -v "ssh$\|.kube$\|.vimrc$" |xargs rm -rf '
# alias DATE=' date +%Y-%m-%d\ %H:%M:%S '
# alias DCD=' docker-compose down '
# alias DCL=' docker ps -a --format {{.Names}} |xargs docker inspect |grep -i --color Source '
# alias DCLF=' docker-compose logs -f '
# alias DCP=' docker-compose ps '
# alias DCUB=' docker-compose down && docker-compose up --build -d '
# alias DIA=' for i in $(DP |AWK 1) ; do docker inspect $i 2>/dev/null |grep IPAddress.*172 ; done '
# alias DLF=' docker logs -f '
# alias DLN=' docker logs -n111 '
# alias DNF=' dnf --disablerepo '*' --enablerepo=extras swap centos-linux-repos centos-stream-repos ; dnf distro-sync '
# alias DOCKERKILL=' docker kill $(docker ps -q) ; docker rm -f $(docker ps -a -q) ; docker rmi -f $(docker images -q) ; docker rm -v $(docker ps -a -q -f status=exited) ; docker rm -v $(docker ps -a -q -f status=created) '
# alias DP2=' docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}} " || podman ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}} " '
# alias DPK=' docker ps -a --format "{{.Names}}" | awk -F_ "{print\$3\"\ \@\ \"\$4}" 2>/dev/null '
# alias DR=' docker restart '
# alias DRA=' for i in $(docker ps -a --format "{{.Names}}") ; do docker restart $i ; done '
# alias DRF=' docker rm -f '
# alias DRLF=' docker-compose down ; docker-compose up -d ;docker-compose logs -f '
# alias DS=' docker stop '
# alias DU=' du -sh 2>/dev/null ; du -hd1 2>/dev/null |grep "G\|M" '
# alias DV=' grep -vE ^\;\|^$ '
# alias EXIF=' exiftool -all= -overwrite_original ./* '
# alias EXIT=' docker rm $(docker ps -a -f status=exited -q) '
# alias FP=' find "$(pwd)" '
# alias FSSL=' curl -fsSL '
# alias GACM=' git add -A ; git commit -m '
# alias GBA=' git branch -a '
# alias GCB=' git checkout -b '
# alias GCU=' [ "$(npm view @google/gemini-cli version)" != "$(gemini --version 2>/dev/null)" ] && sudo npm install -g @google/gemini-cli '
# alias GCUG=' [ "$(npm view @google/gemini-cli version)" != "$(gemini --version 2>/dev/null)" ] && sudo npm install -g @google/gemini-cli ; gemini '
# alias GD=' git --no-pager diff '
# alias GG2=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/GEMINI.md > ~/.gemini/GEMINI.md && curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/settings.json > ~/.gemini/settings.json && sleep 2 && gemini  '
# alias GGS=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/GEMINI.md > ~/.gemini/GEMINI.md ; curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/settings.json > ~/.gemini/settings.json '
# alias GLANCES=' sudo apt-get install -y software-properties-common ; sudo add-apt-repository -y ppa:deadsnakes/ppa ; sudo apt-get update -y ; sudo apt-get install -y python3-pip ; sudo pip3 install pip glances -U '
# alias GPP=' git pull ; git rm -r --cached . > /dev/null ; git add -A ; git commit -amxxxxx > /dev/null ; git push '
# alias GRC2=' git fetch --prune && git reset --hard && git clean -f && git pull ' # git rm -r --cached
# alias GRC2='git fetch --prune && git branch --set-upstream-to=origin/main main && git reset --hard origin/main && git clean -fd'
# alias GRC=' git fetch --prune && git reset --hard && git clean -fd && git pull '
# alias GRC=' git fetch --prune ; git reset --hard && git clean -f -d ; git rm -r --cached . > /dev/null ; git reset --hard ; git pull '
# alias GRI=' grep -ri --color 2>/dev/null ' # -i # didnt search ln
# alias GSN=' git start next '
# alias GURL=' grep -E "([a-zA-Z0-9]+\.[a-zA-Z0-9]+\.[a-zA-Z0-9]+)" ' # -r & -o removed
# alias GURL=' grep -vE index.php\|index.htm\|log.*log\|127.0.0\|1.2.3 | grep -Eo "([a-zA-Z0-9]+\.[a-zA-Z0-9]+\.[a-zA-Z0-9]+)" ' # without -r
# alias GY2=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/GEMINI.md > ~/.gemini/GEMINI.md ; curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/settings.json > ~/.gemini/settings.json ; gemini -y -m gemini-3-flash-preview '
# alias GY2=' gemini -y -m gemini-3-flash-preview '
# alias GY=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/GEMINI.md > ~/.gemini/GEMINI.md ; curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/settings.json > ~/.gemini/settings.json ; gemini -y -m gemini-3-pro-preview '
# alias GY=' gemini -y -m gemini-3-pro-preview '
# alias HG=' cat ~/.bash_history |grep -ai --color '
# alias HH=' cat ~/.bash_history '
# alias HUA=' helm list |grep -v ^NAME |awk "{print\$1}" |xargs helm uninstall '
# alias HUSH=' touch ~/.hushlogin '
# alias INGDEMO=' curl -fsSL https://gitlab.com/ernie18a/misc/-/raw/master/scripts/ing.demo.sh | bash '
# alias INGRESS=' kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.0/deploy/static/provider/cloud/deploy.yaml '
# alias INGRESS=' kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.4/deploy/static/provider/baremetal/deploy.yaml '
# alias INGRESS=' kubectl create ns ingress-nginx ; helm install ingress-nginx bitnami/nginx-ingress-controller -n ingress-nginx '
# alias IPA=' ip a |grep -E ens\|eth\|wlan0 |grep -iE --color "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | awk "{print\$2}"| awk -F/ "{print\$1}" '
# alias IPP=' curl ifconfig.co; curl ifconfig.io '
# alias IPT2=' iptables-save '
# alias IPT=' iptables -t nat -L -n -v '
# alias IPTG=' iptables -t nat -L -n -v | grep -i --color '
# alias KCL=' kubectl create deployment nginx-ernie18a --image=nginx:alpine-slim ; kubectl scale --replicas=2 deployment/nginx-ernie18a ; kubectl expose deployment nginx-ernie18a --type=LoadBalancer --name=nginx-ernie18a --port=80 ; kubectl get svc '
# alias KCX2=' kubectl run --image nginx --port=80 nginx ; kubectl expose pod nginx '
# alias KCX=' kubectl create deployment nginx-ernie18a --image=ernie18a/nginx:v1 ; kubectl scale --replicas=2 deployment/nginx-ernie18a ; kubectl expose deployment nginx-ernie18a --type=LoadBalancer --name=nginx-ernie18a --port=80 ; kubectl get svc '
# alias KDC=' kubectl delete pod --field-selector=status.phase==Succeeded ; echo --all-namespaces ' # cannot define specfc ns
# alias KDELO=' kubectl get all |grep -v ^NAME | grep -v service\/kubernetes | awk "{print\$1}" | xargs kubectl delete --force --grace-period=0 '
# alias KDF=' kubectl delete -f '
# alias KDF=' kubectl delete pod -A --field-selector=status.phase==Failed '
# alias KDL=' kubectl get all |grep nginx-ernie18a |awk "{print\$1}" |xargs kubectl delete '
# alias KDN=' kubectl describe nodes '
# alias KDP=' kubectl describe pod '
# alias KDX2=' kubectl delete po nginx ; kubectl delete svc nginx '
# alias KGAA=' kubectl get all -A '
# alias KGAPFNR=' kubectl get pods --field-selector status.phase!=Running -A '
# alias KGAS=' kubectl get -A svc |grep -v nfs-nfs-server-provisioner '
# alias KGASW=' kubectl get svc -A -o custom-columns="NAMESPACE:{metadata.namespace},NAME:{metadata.name},TYPE:{spec.type},CLUSTER-IP:{spec.clusterIP},EXTERNAL-IP:{.status.loadBalancer.ingress[*].ip},PORD:{.spec.ports[*].port}" '
# alias KGASW=' kubectl get svc -A -o wide -o custom-columns="NAMESPACE:{metadata.namespace},NAME:{metadata.name},TYPE:{spec.type},CLUSTER-IP:{spec.clusterIP},EXTERNAL-IP:{.status.loadBalancer.ingress[*].ip},PORD:{.spec.ports[*].port}" '
# alias KGES=' kubectl get event -A -o custom-columns="NAME:{metadata.name},MESSAGE:{message}" '
# alias KGY=' kubectl get -o yaml'
# alias KL=' kubectl logs --all-containers '
# alias KREW=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.kube.krew.sh | bash '
# alias KUS=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.kube.kustomize.sh | bash '
# alias LONGHORN=' kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/master/deploy/longhorn.yaml '
# alias LTH=' sed -i "/PUSHM\|rere\|nmap\|nc\|.bash_history\|help\|CNG\|CBG\|reboot\|poweroff\|HISTFILE\|help\|mtr\|gping\|BRC\|wget\|NC\|ping\|curl\|HG\|HH\|LTH\|STEALTH\|source\|SAS\|export\|history\|rm\|ernie18a\|sshrc\|rsync\|scp\|scpr/d" ~/.bash_history ; rm -rf /tmp/*sshrc* '
# alias LTH=' sed -i "/help\|/mtr\|gping\|BRC\|wget\|NC\|ping\|curl\|HG\|HH\|LTH\|STEALTH\|source\|SAS\|export\|history\|rm\|ernie18a\|sshrc\|rsync\|scp\|scpr/d" ~/.bash_history ; rm -rf /tmp/*sshrc* '
# alias LTH=' sed -i "/mtr\|gping\|BRC\|wget\|NC\|ping\|curl\|HG\|HH\|LTH\|STEALTH\|source\|SAS\|export\|history\|rm\|ernie18a\|sshrc\|rsync\|scp\|scpr/Id" ~/.bash_history ; rm -rf /tmp/*sshrc* '
# alias M24=' for i in *.webm;do ffmpeg -y -i "$i" "$(echo "$i"|cut -d\. -f1).mp4"; done '
# alias M2G=' for i in *.webm;do ffmpeg -y -i "$i" "$(echo "$i"|cut -d\. -f1).gif"; done '
# alias MASTER=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.kube.master.sh | bash '
# alias MC=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.minecraft.sh | bash '
# alias METAL=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.metallb.sh | bash '
# alias METRICS=' kubectl apply -f https://gitlab.com/ernie18a/dotfiles/-/raw/main/misc/metrics-server.yaml '
# alias MINI=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.minikube.sh | bash '
# alias MINI=' curl -fssL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/e.minimum.sh | bash '
# alias MINIO=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.kube.minio.sh | bash '
# alias NE=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.node.exporter.sh | bash '
# alias NN=' netstat -an -ptcp | grep LISTEN | V 127.0.0.1 | V ::1 '
# alias NPMGG2=' sudo npm install -g npm ; sudo npm install -g @google/gemini-cli ; gemini '
# alias NPMGG=' sudo npm install -g npm ; [ "$(npm view @google/gemini-cli version)" != "$(gemini --version 2>/dev/null)" ] && sudo npm install -g @google/gemini-cli ; gemini '
# alias NPMGG=' sudo npm install -g npm ; sudo npm install -g @google/gemini-cli ; curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/GEMINI.md > ~/.gemini/GEMINI.md ; curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/settings.json > ~/.gemini/settings.json ; gemini  '
# alias NVIM=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.nvim.sh | bash '
# alias NVS=' nvidia-smi '
# alias OL=' ollama list ; ollama ps ; echo -e "\n" ; echo ollama run ; echo -e "\n" '
# alias OLR=' ollama run $1 ; ollama stop $1 ; SYSS ollama ; sleep 3 ; SYSR ollama ; ollama run $1 '
# alias ORACLE=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.oracle.sh | bash '
# alias OVT=' apt-get update 2>/dev/null ; apt-get install -y open-vm-tools 2>/dev/null ||yum install -y open-vm-tools 2>/dev/null ; systemctl restart vmtoolsd.service ; systemctl enable vmtoolsd.service'
# alias P2P=' for i in *.webp;do ffmpeg -y -i "$i" "$(echo "$i"|cut -d\. -f1).png"; done '
# alias PIP2=' deactivate ; rm .venv* ; uv venv ; source .venv/bin/activate ; uv pip install -r .requirements.txt '
# alias PIU=' pip3 install -U '
# alias PIU=' sudo pip3 install -U ' # --system
# alias PIU=' umask 022 ; sudo pip3 install -U '
# alias PRUNE=' docker system prune -fa 2>/dev/null ; docker system prune -f --volumes 2>/dev/null '
# alias PUB=' curl -fssL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/e.pub.sh | bash '
# alias PULL=' git pull '
# alias PUSH=' git rm -r --cached . > /dev/null ; git add -A ; git commit -amxxxxxxx > /dev/null ; git push '
# alias PY=' python3 -m venv venv; source venv/bin/activate; pip3 install -r requirements.txt '
# alias REPO=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.rhel.repo.mount.sh | bash '
# alias RMH=' sed -i "/$1/d" ~/.bash_history '
# alias RUNNER=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.runner.sh | bash '
# alias SA=' eval $(ssh-agent) 1>/dev/null ; ssh-add ~/.ssh/id_rsa &>/dev/null '
# alias SAS=' eval $(ssh-agent) 1>/dev/null ; ssh-add ~/.ssh/id_rsa &>/dev/null ; ssh '
# alias SCT=' ssh -o ConnectTimeout=300 '
# alias SINGLE2=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/_kube.single.sh | bash '
# alias SN='
# alias SOURCE=' source /dev/stdin <<< "$(curl -Ls https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/.bash_profile)" '
# alias SS=' ss -nlp |V 127.0.0 |GE ":\*" |column -t '
# alias SS=' ss -nlp |V 127.0.0 |GE ":\*" |column -t 2>/dev/null || ss -nlp |V 127.0.0 |GE ":\*" '
# alias SS=' ss -ntlp '
# alias SS=' ss -ntlp |grep -v 127.0.0.1 '
# alias SS=' ss -pln |GE ^tcp\|^udp\|Address:Port | column -t 2>/dev/null || ss -pln |GE ^tcp\|^udp '
# alias SS=' ss -pln |V \ 127\. |GE ^tcp\|^udp | column -t 2>/dev/null || ss -pln |V \ 127\. |GE ^tcp\|^udp '
# alias SS=' ss -pln |VE 127.0.\|^u_ |grep LISTEN | column -t 2>/dev/null || ss -pln |grep -v LISTEN |VE 127.0.\|^u_ '
# alias SSG=' ss -pln |GE ^tcp\|^udp |grep -i --color '
# alias SSG=' ss -pln |V \ 127\. |GE ^tcp\|^udp |grep -i --color '
# alias SU=' echo "source /tmp/.e.sshrc.*/.sshrc" ; echo "source /home/$(whoami)/.bash_profile " ; sudo su - '
# alias SUDOER=' for i in $(ls /home/) ; do echo "$i ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers ; done '
# alias SUS=' | sort | uniq -c | sort -nk2 '
# alias TERRAFORM=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.terraform.apt.sh | bash '
# alias TFA=' [ -f maina.tf ] && rm .* ; vim main.tf ; terraform init ; terraform apply -auto-approve ' # terraform plan
# alias TMP=' sudo rm -rf /tmp/{.,}* || rm -rf /tmp/{.,}* '
# alias TMUX=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.tmux.sh | bash '
# alias TPLT=' rm ~/.ssh/known_hosts ; echo 172.16.169.2 ; ssh -o ConnectTimeout=2 root@172.16.169.251 2>/dev/null '
# alias TRANS=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.transmission.sh | bash '
# alias TnS=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.transmission.N.shadowsocks-libev.sh | bash '
# alias V200=' grep -iv " 200 \| 200$" '
# alias VDF=' vagrant destroy -f '
# alias VEH=' sudo vim /etc/hosts || vim /etc/hosts '
# alias VENV=' python3 -m venv venv ; source venv/bin/activate ; pip install --upgrade pip ; pip install yt-dlp '
# alias VER=' git verify '
# alias VGP=' cd ~/.G/dotfiles ; git pull >/dev/null ; vim ~/.G/dotfiles/home/GEMINI.md ; cat ~/.G/dotfiles/home/GEMINI.md > ~/.gemini/GEMINI.md ; git rm -r --cached . >/dev/null ; git add -A ; git commit -amGEMINI.md &> /dev/null ; git push 1>/dev/null ; cd - &>/dev/null '
# alias VGP=' cd ~/.G/dotfiles ; git pull >/dev/null ; vim ~/.G/dotfiles/home/GEMINI.md ; git rm -r --cached . >/dev/null ; git add -A ; git commit -amGEMINI.md &> /dev/null ; git push 1>/dev/null ; cd - &>/dev/null '
# alias VGP=' vim .gitlab-ci.yml ; git rm -r --cached . > /dev/null ; git add -A ; git commit -amxxxxxx &> /dev/null ; git push '
# alias VIMRC=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/.vimrc >> ~/.vimrc '
# alias VPP=' cd ~/.G/private/data ; git pull >/dev/null ; vim RANDOM.txt ; git rm -r --cached . > /dev/null ; git add -A && git commit -amVPP &> /dev/null && git push ; cd - &>/dev/null '
# alias VRP=' git pull && vim README.md && git rm -r --cached . > /dev/null && git add -A && git commit -amREADME.md\ update &> /dev/null && git push '
# alias VRP=' git pull && vim README.md && git rm -r --cached . > /dev/null && git add -A && git commit -amREADME.md\ update &> /dev/null && git push ' # DEPRECATED
# alias VS=' vagrant ssh '
# alias VU=' vagrant up ' # --provider hyperv
# alias VVF=' vim Vagrantfile '
# alias WD=' date +%A '
# alias WIDTH=' tput cols '
# alias WKGAPFNR=' watch "kubectl get po -A |grep -v Running" '
# alias WSL=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.wsl.sh | bash '
# alias WV=' /mnt/c/HashiCorp/Vagrant/bin/vagrant.exe '
# alias WVDF=' /mnt/c/HashiCorp/Vagrant/bin/vagrant.exe destroy -f '
# alias WVS=' /mnt/c/HashiCorp/Vagrant/bin/vagrant.exe ssh '
# alias WVU=' /mnt/c/HashiCorp/Vagrant/bin/vagrant.exe up '
# alias WVUS2=' ls Vagrantfile &>/dev/null || cd $WIN_USER_DIR/vagrant ; /mnt/c/HashiCorp/Vagrant/bin/vagrant.exe status |grep running && /mnt/c/HashiCorp/Vagrant/bin/vagrant.exe ssh || /mnt/c/HashiCorp/Vagrant/bin/vagrant.exe up ; /mnt/c/HashiCorp/Vagrant/bin/vagrant.exe ssh '
# alias WVUS=' ls Vagrantfile &>/dev/null || cd $WIN_USER_DIR/vagrant ; /mnt/c/HashiCorp/Vagrant/bin/vagrant.exe up ; /mnt/c/HashiCorp/Vagrant/bin/vagrant.exe ssh '
# alias YSDL=' sudo yum --showduplicates list ' # $1
# alias bcr=' bat -ppl rb '
# alias ccd=' cd '
# alias cp=' cp -urf '
# alias cpum=' grep processor /proc/cpuinfo |wc |awk "{print\$1}" ; free -h |grep Mem: |awk "{print\$2}" '
# alias dietpi=' ssh dietpi@0 -p20 '
# alias freeh=' free -h '
# alias l=' ls --color -ld .?* '
# alias l=' ls -ap --color | grep "^\."  --color '
# alias lgc=' lg bat | xargs cat '
# alias lgc=' ls -Ah |grep -i |xargs cat '
# alias llc=' ls --color -l '
# alias lllc=' ls --color -Alh '
# alias nss=' ssh -i ~/.ssh/nss2.pem '
# alias sed=' gsed 2>/dev/null || sed '
# alias sl=' ls '
# alias tmprm=' sudo rm -rf /tmp/{,.}* 2>/dev/null ; ls -A /tmp && echo /tmp\ is\ now\ empty '
# alias u250=' ssh root@0 -p21 '
# cd ~	
# eval $(ssh-agent) ; ssh-add ~/.ssh/id_rsa
# export CONTAINER_RUNTIME_ENDPOINT=/run/containerd/containerd.sock
# export CRIT_CONFIG=/etc/crictl.yaml
# export DEBIAN_FRONTEND=noninteractive
# export GITHUB_MCP_PAT=$(cat ~/.55H &>/dev/null)
# export GOOSE_MODEL=hf.co/bartowski/Qwen2.5-Coder-7B-Instruct-GGUF:Q6_K
# export GOOSE_PROVIDER=ollama
# export HISTTIMEFORMAT="%F %T " &>/dev/null
# export IMAGE_SERVICE_ENDPOINT=/run/containerd/containerd.sock
# export LANG=en_US.UTF-8 &>/dev/null
# export LANGUAGE=en_US.UTF-8 &>/dev/null
# export LC_ALL=en_US.UTF-8 &>/dev/null
# export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.krew/bin:$GOPATH/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/snap/bin"
# export PATH="/bin:/sbin:/usr/bin:/usr/games:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/sbin:~/.local/bin:~/.cargo/bin:$HOME/.krew/bin:/snap/bin"
# export PATH="/bin:/sbin:/usr/bin:/usr/games:/usr/local/bin:/usr/local/sbin:/usr/sbin:~/.local/bin:~/.cargo/bin:${KREW_ROOT:-$HOME/.krew}/bin"
# export PATH="/bin:/sbin:/usr/bin:/usr/games:/usr/local/bin:/usr/local/sbin:/usr/sbin:~/.local/bin:~/.cargo/bin:/root/.krew/bin"
# export PATH="/bin:/sbin:/usr/bin:/usr/games:/usr/local/bin:/usr/local/sbin:/usr/sbin:~/.local/bin:~/.cargo/bin:~/.krew/bin"
# export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# export PS1="[\\h \w \$(__git_ps1 '%s')] \\$ "
# export PS1="[\\h \w \$(git rev-parse --abbrev-ref HEAD 2>/dev/null)] \\$ "
# export PS1="[\u@\h \w]\\$ \[$(tput sgr0)\]"
# export VAGRANT_DISABLE_VBOXSYMLINKCREATE=1
# export VMWARE_VALIDATE_CERTS=no
# function
# gvbc() { grep -v ^\ *$ |grep -v ^\ *# |grep -v ^\t*$ |grep -v ^\t*# |grep -v ^$'\r' | grep -vP ^'\t*#'| bat -ppl rb ; }
# gvbcl() { grep -v ^\ *$ |grep -v ^\ *# |grep -v ^\t*$ |grep -v ^\t*# |grep -v ^$'\r' | grep -vP ^'\t*#'| bat -ppl $1 $2 ; }
# keychain --nogui ~/.ssh/id_rsa ; source ~/.keychain/$(hostname)-sh
# lgc() { ls -Ah |grep -i $1 |xargs cat ; }
# lgcd() { ls -Ah |grep -i $1 |xargs cd ; }
# llgm() {if [[ $(ls |grep -i $1 |wc -l) = 1 ]] ; then mv *$1* ../_p*/_a ; fi }
# nss() { ssh -i ~/.ssh/nss2.pem ubuntu@$1 ; } 
# nss2() { ssh $1 sudo docker ps | wc ; }
# nsscp() { scp -ri ~/.ssh/nss2.pem ubuntu@$1 ; }
# source /System/Volumes/Data/private/etc/bash_completion.d/* 2>/dev/null
# source /dev/stdin <<< "$(curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh)" # change it to source local to bypass network unreachable
# source ~/.inputrc
# touch ~/.hushlogin # disabled due to 15u9312
DOCKERTP() { sudo docker tag $1 ernie18a/$2:$3 ; sudo docker push ernie18a/$2:$3 ; }
HI() { helm install $(echo -n $1 |AWK 2 -F/) $1 -n $2 2>/dev/null || helm install $(echo -n $1 |AWK 2 -F/) $1 ; }
HLA() { helm ls -A |awk '{print $2"\t"$1}' | column -t || echo apt\ install\ -y\ bsdmainutils ; }
HSRG() { helm search repo $1 |grep -i --color $1 ; }
INGRESS() { helm install ingress-nginx ingress-nginx/ingress-nginx -n kube-system ; kubectl patch IngressClass nginx -p '{"metadata": {"annotations":{"ingressclass.kubernetes.io/is-default-class":"true"}}}' ; }
KDKN() { kubectl $1 $2 $3 -n $(kubectl get $2 -A | grep $3 | awk "{print\$1}") ; }
KEI() { kubectl exec -it $1 -- $2 2>/dev/null || kubectl -n kube-system exec -it $1 -- $2 2>/dev/null ; }
KLPN() { kubectl logs $1 -n $(kubectl get po -A | grep $1 | awk "{print\$1}") ; }
alias CDC=' cat docker-compose.yml '
alias CKR=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.kube.reset.sh |bash '
alias DCD=' sudo docker-compose down '
alias DCR2=' docker-compose down ; docker-compose up -d '
alias DCR=' sudo docker-compose down ; sudo docker-compose up -d '
alias DEI=' sudo docker exec -it '
alias DIL=' sudo docker image list '
alias DIR=' sudo docker image rm '
alias DL=' sudo docker logs '
alias DOCKER=' curl -fssL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.docker.sh | bash '
alias DP=' sudo docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}} " '
alias DPG=' sudo docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}} " |grep --color -i '
alias DPS=' for i in $(sudo docker ps |grep -v STATUS |awk "{print\$1}") ; do sudo docker inspect $i |grep -v \/var\/lib |grep Source ; done '
alias DRF=' sudo docker rm -f '
alias DRFA=' sudo docker rm -f $(sudo docker ps -a -q) '
alias DS=' echo "--no-stream" ; sudo docker stats '
alias HELM=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.helm.sh | bash '
alias HSR=' helm search repo '
alias HU=' helm uninstall '
alias IPA=' ip a |grep scope\ global |grep -vE docker\|br\- |grep -iE --color "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | awk "{print\$2}"| awk -F/ "{print\$1}" '
alias KAF=' kubectl apply -f '
alias KARF=' kubectl apply --recursive -f . '
alias KARG=' kubectl api-resources |grep -i --color '
alias KCG=' kubectl config get-contexts '
alias KCU=' kubectl config use-context '
alias KCX=' kubectl run --image nginx:alpine-slim nginx-ernie-test --port 80 ; kubectl expose pod nginx-ernie-test --type LoadBalancer --name nginx-ernie-test --port 80 ; kubectl get svc '
alias KD=' kubectl describe '
alias KDEL=' kubectl delete '
alias KDELP=' kubectl get pvc |AWK 1 |xargs kubectl delete pvc ; KG pv |AWK 1 |xargs kubectl delete pv '
alias KDF=' kubectl delete -f '
alias KDRF=' kubectl delete --recursive -f . &>/dev/null '
alias KDS=' kubectl delete pod -A --field-selector=status.phase==Succeeded '
alias KDX=' kubectl delete po nginx-ernie-test ; kubectl delete svc nginx-ernie-test '
alias KE=' kubectl edit '
alias KG=' kubectl get '
alias KGA=' kubectl get -A '
alias KGAAG=' kubectl get all -A |grep -i --color '
alias KGAP=' kubectl get pod -A '
alias KGAPG=' kubectl get pod -A |grep -i --color '
alias KGAPV=' kubectl get -A pv ; kubectl get -A pvc '
alias KGAS=' kubectl get svc -A -o custom-columns="NAMESPACE:{metadata.namespace},NAME:{metadata.name},TYPE:{spec.type},CLUSTER-IP:{spec.clusterIP},EXTERNAL-IP:{.status.loadBalancer.ingress[*].ip},PORD:{.spec.ports[*].port}" '
alias KGASG=' kubectl get svc -A -o custom-columns="NAMESPACE:{metadata.namespace},NAME:{metadata.name},TYPE:{spec.type},CLUSTER-IP:{spec.clusterIP},EXTERNAL-IP:{.status.loadBalancer.ingress[*].ip},PORD:{.spec.ports[*].port}" |grep -i --color '
alias KGE=' kubectl get event -A -o custom-columns="LAST SEEN:{lastTimestamp},NAME:{metadata.name},KIND:{involvedObject.kind},TYPE:{type},MESSAGE:{message}" |sort -V '
alias KGEVN=' kubectl get event -A -o custom-columns="LAST SEEN:{lastTimestamp},NAME:{metadata.name},TYPE:{type},MESSAGE:{message}" |grep -v Normal '
alias KIL=' kubectl get pods -A -o jsonpath="{.items[*].spec.containers[*].image}" |tr -s "[[:space:]]" "\n" |sort |uniq '
alias KL=' kubectl logs '
alias KP=' kubectl get po -A -o custom-columns=NAME:.metadata.name,READY:.status.containerStatuses[0].ready,STATUS:.status.phase | grep -v true.*Running ' # |grep -vE Running\|Complete
alias PRUNE=' sudo docker system prune -f --volumes 2>/dev/null ; docker volume prune -af 2>/dev/null '
alias PRUNEI=' sudo docker system prune -fa 2>/dev/null ; docker volume prune -af 2>/dev/null '
alias SINGLE=' curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/i.kube.single.sh | bash '
alias VDC=' vim docker-compose.yml '
alias WKGAP=' watch kubectl get pod -A '
alias WKGAS=' watch kubectl get svc -A '
export KUBE_EDITOR=/bin/vim &>/dev/null
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.krew/bin:$HOME/go/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/snap/bin:/opt/homebrew/bin:/Users/ernieho/Library/Python/3.9/bin:$HOME/.docker/cli-plugins:$HOME/bin"
#alias GRC3='git fetch --prune && git rm -r --cached . && git reset --hard && git clean -fd && git pull'
#YTDLA() { yt-dlp --js-runtimes node -f "ba/b" -x --no-check-certificate -i -a "$1"; }
#YTDLA2() { yt-dlp --js-runtimes node -f "ba/w" -x --no-check-certificate -i --audio-format wav --postprocessor-args "ffmpeg:-ac 1 -ar 16000" --no-warnings -a "$1" ; }
#YTDLV() { yt-dlp --js-runtimes node -i --no-check-certificate -a "$1"; }
#GGRCA3() { (cd /g; for R in */; do [[ -d "$R/.git" ]] || continue; (cd "$R"; git fetch -p && git rm -r --cached . && git reset --hard && git clean -fd && git pull) & done; wait); }
#GRCA3()  { (cd ~/.G; for R in */; do (cd "$R"; git fetch -p && git rm -r --cached . && git reset --hard && git clean -fd && git pull) & done; wait); }
#alias GRC3='git fetch --prune && git reset --hard && git clean -fd && git pull'
#alias GRC=' git fetch --prune && git rm -r --cached . && git reset --hard && git clean -fd && git pull '
#GGRCA2() { (cd /g; for R in */; do [[ -d "$R/.git" ]] || continue; (U=$(git -C "$R" remote get-url origin) && rm -rf "$R" && git clone -q "$U" "$R") & done; wait); }
#GGRCA() { (cd /g; for R in */; do [[ -d "$R/.git" ]] || continue; (cd "$R"; git fetch -p && git reset --hard && git clean -fd && git pull) & done; wait); }
#GRC2() { local T=$(git rev-parse --show-toplevel 2>/dev/null) || return 1; local U=$(git -C "$T" remote get-url origin) || return 1; local R=$(basename "$T"); local P="${PWD#$T}"; cd "$(dirname "$T")" && rm -rf "$R" && git clone "$U" "$R" && cd "$R$P"; }
#GRCD() { local _old="$PWD"; cd ~/.G/dotfiles && git fetch --prune && git reset --hard && git clean -fd && git pull; cd "$_old"; }
#GRCA2() { (cd ~/.G; for R in */; do (U=$(git -C "$R" remote get-url origin) && rm -rf "$R" && git clone -q "$U" "$R") & done; wait); }
#GRCA()  { (cd ~/.G; for R in */; do (cd "$R"; git fetch -p && git reset --hard && git clean -fd && git pull) & done; wait); }
#source /usr/share/bash-completion/bash_completion 2>/dev/null
#export CUDA_LAUNCH_BLOCKING=1
# alias USAGE=' sudo UV_CACHE_DIR=/g/app/usage/TMP/.uv-cache uv run /g/app/usage/main.py '
#alias USAGE='(cd /g/app/usage && sudo env UV_CACHE_DIR=/g/app/usage/TMP/.uv-cache uv run main.py)'
# alias USAGE='(cd /g/app/usage && sudo -i uv run /g/app/usage/main.py )'
#alias UU=' sudo apt update && sudo apt install claude-code -y ; sudo agy update ; sudo npm install -g --force @openai/codex ' # ; sudo hermes update '
#alias UG=' [ "$(npm view npm version)" != "$(npm -v)" ] && sudo npm install -g npm ; [ "$(npm view @google/gemini-cli version)" != "$(gemini --version 2>/dev/null)" ] && sudo npm install -g @google/gemini-cli ; gemini '
#alias BNA=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/e.brc.n.auth.sh | bash '
#alias CGI=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/e.gemini.api.sh | bash '
#alias GEMINI=' curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/main/curl/i.gemini.sh | bash '
# alias SB=' source ~/.G/dotfiles/home/.bash_profile 2>/dev/null || source /dev/stdin <<< "$(curl -Ls https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile)" ; cd - &>/dev/null '
# alias ACL3=' sudo find /g -type d -exec chmod 2777 {} + ; sudo find /g -type d -exec setfacl -m m:rwx,d:m:rwx {} + '
#alias NPMG=' sudo npm install -g npm ; sudo npm install -g @google/gemini-cli '
# alias ACL=' sudo setfacl -R -b /g ; sudo setfacl -R -m u::rwx,g::rwx,o::rwx,m:rwx /g ; sudo setfacl -R -d -m u::rwx,g::rwx,o::rwx,m:rwx /g ; sudo chattr -R -i -a /g 2>/dev/null || true '
#UR() { if [ -n "$1" ]; then uv run --no-project "$1"; else uv run --no-project main.py; fi; }
#complete -C '/usr/local/bin/aws_completer' aws &>/dev/null
#complete -C /usr/bin/terraform terraform
#alias CSG=' cat ~/.ssh/config | grep -i --color '
#BRC() { curl -Ls https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile |grep -vEi raw.githubusercontent.com\|git_ps1 | ssh $1 "cat > .BRC" ; }
#DUAL() { UV_PROJECT_ENVIRONMENT=/g/.TMP/sdk-venv UV_CACHE_DIR=/g/.TMP/uv-cache XDG_CACHE_HOME=/g/.TMP/xdg-cache uv run --project /g/app/dual --directory "$PWD" python -m dual "$@"; }
#export LS_COLORS="$LS_COLORS:sg=0"
#export BERT_MODELS_DIR=/g/.TMP/bert-models
#export CLOAKBROWSER_CACHE_DIR=/g/.TMP/cloakbrowser
#export CUDA_CACHE_MAXSIZE=2147483647
#export CUDA_CACHE_PATH=/g/.TMP/cuda-cache
#export CUDA_DEVICE_MAX_CONNECTIONS=32
#export CUDA_MANAGED_FORCE_DEVICE_ALLOC=1
#export HF_HOME=/g/.TMP/huggingface
#export HF_HUB_CACHE=/g/.TMP/huggingface/hub
#export HUGGINGFACE_HUB_CACHE=/g/.TMP/huggingface/hub
#export MECABRC=/g/.TMP/mecab/mecabrc
#export MODELSCOPE_CACHE=/g/.TMP/modelscope
#export MPLCONFIGDIR=/g/.TMP/matplotlib
#export NUMBA_CACHE_DIR=/g/.TMP/numba-cache
#export NVM_DIR="$HOME/.nvm"
#export OPEN_JTALK_DICT_DIR=/g/.TMP/open-jtalk-dict
#export PIP_CACHE_DIR=/g/.TMP/pip-cache
#export PLAYWRIGHT_BROWSERS_PATH=/g/.TMP/playwright-browsers
#export PYTHONPYCACHEPREFIX=/g/.TMP/python-pycache
#export PYTORCH_KERNEL_CACHE_PATH=/g/.TMP/torch-kernel
#export TEMP=/g/.TMP/tmp
#export TMP=/g/.TMP/tmp
#export TMPDIR=/g/.TMP/tmp
#export TORCHINDUCTOR_CACHE_DIR=/g/.TMP/torchinductor-cache
#export TORCH_HOME=/g/.TMP/torch
#export TRANSFORMERS_CACHE=/g/.TMP/huggingface/transformers
#export TRITON_CACHE_DIR=/g/.TMP/triton-cache
#export ULTRALYTICS_DIR=/g/.TMP/ultralytics
#export UV_CACHE_DIR=/g/.TMP/uv-cache
#export XDG_CACHE_HOME=/g/.TMP/xdg-cache
#export XDG_DATA_HOME=/g/.TMP/xdg-data
#export YOLO_CONFIG_DIR=/g/.TMP/ultralytics/config
#export YTDLP_CACHE_DIR=/g/.TMP/ytdlp-cache
#export YTDLP_PATHS=temp:/g/.TMP/ytdlp-temp
#source ~/.IPS 2>/dev/null
# alias USAGE="  date ; sudo -i bash -lc 'cd /g/app/usage && uv run main.py'"
# alias DY=' codex --yolo -m gpt-5.6-luna -c model_reasoning_effort=medium '
#alias QUOTE=' echo -e "\nflexibility to improve adaptability\n\nuser-level instructions\n" '
# alias ll=' ls -l --color '
# alias CDB=' mkdir ~/.BACKUP &>/dev/null ; cd ~/.BACKUP ; ls -A --color |sort '
#alias ACL2='sudo chown -R e:g /g && sudo chmod -R u+rwX,g+rwX,o-rwx /g && sudo chmod -R g+s /g && sudo setfacl -R -m u::rwx,g::rwx,o::-,m::rwx,d:u::rwx,d:g::rwx,d:o::-,d:m::rwx /g'
#ACL() { sudo chown -R e:g /g & sudo find /g -type f -exec chmod a-x {} + & wait && sudo chmod -R u+rwX,g+rwX,o-rwx,g+s /g && sudo setfacl -R -m u::rwX,g::rwX,o::-,m::rwX,d:u::rwx,d:g::rwx,d:o::-,d:m::rwx /g; }
# ACL() { sudo chown -R e:g /g & sudo chmod -R u+rwX,g+rwX,o-rwx,g+s /g & wait && sudo setfacl -R -m u::rwx,g::rwx,o::-,m::rwx,d:u::rwx,d:g::rwx,d:o::-,d:m::rwx /g; }
#alias ACL3=' sudo chown -R :g /g ; sudo chmod -R 2777 /g ; sudo setfacl -R -m u::rwx,g::rwx,o::rwx,m:rwx,d:u::rwx,d:g::rwx,d:o::rwx,d:m:rwx /g '
#alias ACL4=' sudo chown -R e:g /g ; sudo chmod -R 2777 /g ; sudo setfacl -R -m u::rwx,g::rwx,o::rwx,m:rwx,d:u::rwx,d:g::rwx,d:o::rwx,d:m:rwx /g '
#alias llll=' sudo find . '
#CBG() { curl  --connect-timeout 2 -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/home/.bash_profile |grep -i --color $1 2>/dev/null || cat ~/.bash_profile 2>/dev/null |grep -i --color $1 ; }
# DUAL() { UV_PROJECT_ENVIRONMENT=/g/.TMP/dual-venv UV_CACHE_DIR=/g/.TMP/uv-cache XDG_CACHE_HOME=/g/.TMP/xdg-cache uv run --project /g/app/dual --with-editable /g/app/dual --directory "$PWD" python -m dual --config /g/app/dual/dual.toml "$@"; }
#LG3() { local lg3_root=/g/app/lg3; UV_PROJECT_ENVIRONMENT=/g/.TMP/lg3-venv UV_CACHE_DIR=/g/.TMP/uv-cache XDG_CACHE_HOME=/g/.TMP/xdg-cache TMPDIR=/g/.TMP/tmp UV_VENV_CLEAR=0 uv run --project "$lg3_root" --directory "$PWD" LG3 "$@"; }
#LG4() { local lg4_root=/g/app/lg4; UV_PROJECT_ENVIRONMENT=/g/.TMP/lg4-venv UV_CACHE_DIR=/g/.TMP/uv-cache XDG_CACHE_HOME=/g/.TMP/xdg-cache TMPDIR=/g/.TMP/tmp UV_VENV_CLEAR=0 uv run --project "$lg4_root" --directory "$PWD" LG4 "$@"; }
# USAGE() { date ; sudo -i bash -lc 'cd /g/app/usage && uv run main.py' ; }
# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/home/e/google-cloud-sdk/path.bash.inc' ]; then . '/home/e/google-cloud-sdk/path.bash.inc'; fi
# The next line enables shell command completion for gcloud.
#if [ -f '/home/e/google-cloud-sdk/completion.bash.inc' ]; then . '/home/e/google-cloud-sdk/completion.bash.inc'; fi
#export MICRO_CONFIG_HOME="$HOME/.config/micro"
#export XDG_CONFIG_HOME=/g/.TMP/xdg-config
