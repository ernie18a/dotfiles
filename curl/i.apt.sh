#!/bin/bash
APTINSTALL() { local ok=() p; for p in "$@"; do apt-cache show "$p" >/dev/null 2>&1 && ok+=("$p"); done; [ ${#ok[@]} -gt 0 ] && apt-get install -yq "${ok[@]}"; }
APTREMOVE() { local ok=() p; for p in "$@"; do dpkg-query -W "$p" >/dev/null 2>&1 && ok+=("$p"); done; [ ${#ok[@]} -gt 0 ] && apt-get remove -y --allow-remove-essential "${ok[@]}"; }
case "$1" in
  default)
	# default zone
	timedatectl set-timezone Asia/Taipei
	APTREMOVE needrestart 'ufw*' 'apparmor*' 'firewall*' unattended-upgrades landscape-common ubuntu-advantage-tools cloud-init popularity-contest ubuntu-report apport whoopsie fwupd
	apt-get update
	APTINSTALL bash-completion file git jq ripgrep rsync tmux tree vim apt-transport-https software-properties-common ffmpeg acl
	echo ServerAliveInterval\ 30 >> /etc/ssh/ssh_config
	echo StrictHostKeyChecking\ no >> /etc/ssh/ssh_config
	echo TCPKeepAlive\ no >> /etc/ssh/ssh_config
	echo ForwardAgent\ yes >> /etc/ssh/ssh_config
	echo ClientAliveInterval\ 60 >> /etc/ssh/sshd_config
	echo ClientAliveCountMax\ 3 >> /etc/ssh/sshd_config
	swapoff -a ; sed -i '/swap/ s/^/#/' /etc/fstab
	echo "e ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
	rm -f /etc/update-motd.d/50-motd-news
	echo 'source /dev/stdin <<< "$(curl -Ls "https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile?v=$(date +%s)")"' | tee ~/.bash_profile ~/.bashrc /home/e/.bash_profile /home/e/.bashrc
	touch ~/.hushlogin /home/e/.hushlogin
	rm -rf /home/e/.gitconfig
	rm -rf /home/e/.tmux.conf
	rm -rf /home/e/.vimrc
	rm -rf /home/e/.bash_profile
	rm -rf /home/e/.bashrc
	rm -rf /home/e/.codex
	rm -rf /home/e/.gemini
	rm -rf /home/e/.hermes
	rm -rf /home/e/.claude
	mkdir -p /home/e/.codex
	mkdir -p /home/e/.gemini
	mkdir -p /home/e/.hermes
	mkdir -p /home/e/.claude
	echo 'source /dev/stdin <<< "$(curl -Ls "https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile?v=$(date +%s)")"' > /home/e/.bash_profile
	ln -snf /home/e/.G/dotfiles/home/.gitconfig /home/e/.gitconfig
	ln -snf /home/e/.G/dotfiles/home/.tmux.conf /home/e/.tmux.conf
	ln -snf /home/e/.G/dotfiles/home/.vimrc /home/e/.vimrc
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.codex/AGENTS.md
	ln -snf /home/e/.G/dotfiles/skills /home/e/.codex/skills
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.gemini/GEMINI.md
	ln -snf /home/e/.G/dotfiles/skills /home/e/.gemini/skills
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.hermes/SOUL.md
	ln -snf /home/e/.G/dotfiles/skills /home/e/.hermes/skills
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.claude/CLAUDE.md
	ln -snf /home/e/.G/dotfiles/skills /home/e/.claude/skills
	chown -R e:e /home/e
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.ssh.pub.sh | bash
	;;
  dev)
	# dev zone
	curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
#	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.claude.sh | bash
	apt-get update
	APTINSTALL nodejs claude-code acl
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.rust.sh | bash
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.uv.sh | bash
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.codex.sh | bash
#	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.agy.sh | bash
	;;
  wsl)
# wsl zone
	export WIN_USER=$(ls /mnt/c/Users | grep -iv "All\|Default\|desktop.ini\|Public\|USER\|Administrator\|super")
	export WIN_USER_DIR=/mnt/c/Users/$WIN_USER
	export WIN_USER_DL=/mnt/c/Users/$WIN_USER/Downloads
	unzip $WIN_USER_DL/ernie-master.zip
	mkdir ~/.ssh
	cat ernie-master/.ssh/id_ed25519 > ~/.ssh/id_ed25519
	cat ernie-master/.ssh/id_ed25519.pub > ~/.ssh/id_ed25519.pub
	chmod 0700 ~/.ssh
	chmod 0600 ~/.ssh/id_ed25519
	chmod 0644 ~/.ssh/id_ed25519.pub
	cp -rf ~/.ssh /home/e/.ssh
	chmod 0700 /home/e/.ssh
	chmod 0600 /home/e/.ssh/id_ed25519
	chmod 0644 /home/e/.ssh/id_ed25519.pub
	mkdir /home/e/.G/
	cd /home/e/.G/
	git clone git@github.com:ernie18a/dotfiles.git
	git clone git@github.com:ernie18a/misc.git
	git clone git@github.com:ernie18a/deprecated.git .deprecated
	git clone https://github.com/tmux-plugins/tpm /home/e/.G/.tmux_plugins_manager
	sed -i 's/https:\/\/github.com\/ernie18a\/dotfiles.git/git@github.com:ernie18a\/dotfiles.git/g' /home/e/.G/dotfiles/.git/config
	chown -R e:e /home/e
		;;
  mu)
	groupadd -f g
	for user in o n; do
	  if ! id -u "$user" >/dev/null 2>&1; then
	    useradd "$user" -ms /bin/bash
	    echo "$user:$user" | chpasswd
	  fi
	done
	for user in e o n; do
	  if id -u "$user" >/dev/null 2>&1; then
	    usermod -aG g "$user"
	  fi
	done
	mkdir -p /g
	chown -R :g /g
	chmod -R 2777 /g
	setfacl -R -m u::rwx,g::rwx,o::rwx,m:rwx,d:u::rwx,d:g::rwx,d:o::rwx,d:m:rwx /g

	if [ -d /home/e/.G ]; then
	    for user in o n; do
	      if id -u "$user" >/dev/null 2>&1; then
	        rm -rf /home/$user/.*
	        cp -r /home/e/.G /home/$user/.G
	        cp -r /home/e/.ssh /home/$user/.ssh
	        cp -r /home/e/.55H /home/$user/
	      fi
	    done
	    for user in o n; do
	      if id -u "$user" >/dev/null 2>&1; then
	        rm -rf /home/$user/.gitconfig
	        rm -rf /home/$user/.tmux.conf
	        rm -rf /home/$user/.vimrc
	        rm -rf /home/$user/.bash_profile
	        rm -rf /home/$user/.bashrc
	        rm -rf /home/$user/.codex
	        rm -rf /home/$user/.gemini
	        rm -rf /home/$user/.hermes
	        rm -rf /home/$user/.claude
	        mkdir -p /home/$user/.codex
	        mkdir -p /home/$user/.gemini
	        mkdir -p /home/$user/.hermes
	        mkdir -p /home/$user/.claude
	        echo 'source /dev/stdin <<< "$(curl -Ls "https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile?v=$(date +%s)")"' > /home/$user/.bash_profile
	        ln -snf /home/$user/.G/dotfiles/home/.gitconfig /home/$user/.gitconfig
	        ln -snf /home/$user/.G/dotfiles/home/.tmux.conf /home/$user/.tmux.conf
	        ln -snf /home/$user/.G/dotfiles/home/.vimrc /home/$user/.vimrc
	        ln -snf /home/$user/.G/dotfiles/home/GEMINI.md /home/$user/.codex/AGENTS.md
	        ln -snf /home/$user/.G/dotfiles/skills /home/$user/.codex/skills
	        ln -snf /home/$user/.G/dotfiles/home/GEMINI.md /home/$user/.gemini/GEMINI.md
	        ln -snf /home/$user/.G/dotfiles/skills /home/$user/.gemini/skills
	        ln -snf /home/$user/.G/dotfiles/home/GEMINI.md /home/$user/.hermes/SOUL.md
	        ln -snf /home/$user/.G/dotfiles/skills /home/$user/.hermes/skills
	        chown -R $user:$user /home/$user/
	      fi
	    done
	fi

	for user in o n; do
	  if id -u "$user" >/dev/null 2>&1; then
	    chown -R $user:$user /home/$user
	  fi
	done
	;;
  vm)
# vm zone
	# Replace this comment with the actual commands to be executed for Ampere
	;;
esac
