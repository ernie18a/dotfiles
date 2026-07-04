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
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.ssh.pub.sh | bash
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.users.sh | bash
	;;
  dev)
	# dev zone
	curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.claude.sh | bash
	apt-get update
	APTINSTALL nodejs claude-code acl
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.rust.sh | bash
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.uv.sh | bash
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.codex.sh | bash
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.agy.sh | bash
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.users.sh | bash
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
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.users.sh | bash
		;;
  vm)
# vm zone
	# Replace this comment with the actual commands to be executed for Ampere
	;;
esac
