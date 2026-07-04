#!/bin/bash
case "$1" in
  default)
	# default zone
	timedatectl set-timezone Asia/Taipei
	apt-get remove -y --allow-remove-essential needrestart ufw* apparmor* firewall* unattended-upgrades landscape-common ubuntu-advantage-tools cloud-init popularity-contest ubuntu-report apport whoopsie fwupd
	apt-get update
	apt-get install -yq \
		bash-completion file git jq ripgrep rsync tmux tree vim \
		apt-transport-https software-properties-common ffmpeg
	echo ServerAliveInterval\ 30 >> /etc/ssh/ssh_config
	echo StrictHostKeyChecking\ no >> /etc/ssh/ssh_config
	echo TCPKeepAlive\ no >> /etc/ssh/ssh_config
	echo ForwardAgent\ yes >> /etc/ssh/ssh_config
	echo ClientAliveInterval\ 60 >> /etc/ssh/sshd_config
	echo ClientAliveCountMax\ 3 >> /etc/ssh/sshd_config
	swapoff -a ; sed -i '/swap/ s/^/#/' /etc/fstab
	echo "e ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
	echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
	rm -f /etc/update-motd.d/50-motd-news
	echo 'source /dev/stdin <<< "$(curl -Ls "https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile?v=$(date +%s)")"' | tee ~/.bash_profile ~/.bashrc /home/e/.bash_profile /home/e/.bashrc /home/ubuntu/.bash_profile /home/ubuntu/.bashrc
	touch ~/.hushlogin /home/e/.hushlogin /home/ubuntu/.hushlogin
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.ssh.pub.sh | bash
	;;
  dev)
	# dev zone
	curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.claude.sh | bash
	apt-get update
	apt-get install -yq nodejs claude-code build-essential cargo pkg-config rustc rustfmt acl cmake
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.codex.sh | bash
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.agy.sh | bash
	;;
  wsl)
# wsl zone
		export WIN_USER=$(ls /mnt/c/Users | grep -iv "All\|Default\|desktop.ini\|Public\|USER\|Administrator\|super")
		export WIN_USER_DIR=/mnt/c/Users/$WIN_USER
		export WIN_USER_DL=/mnt/c/Users/$WIN_USER/Downloads
	unzip $WIN_USER_DL/ernie-master.zip
	mkdir ~/.ssh
	cat ernie-master/.ssh/id_ed25519 > ~/.ssh/id_ed25519
	chmod 0700 ~/.ssh
	chmod 0600 ~/.ssh/id_ed25519
	cp -rf ~/.ssh /home/e/.ssh
	chmod 0700 /home/e/.ssh
	chmod 0600 /home/e/.ssh/id_ed25519
	mkdir /home/e/.G/
	cd /home/e/.G/
	git clone git@github.com:ernie18a/dotfiles.git
	git clone git@github.com:ernie18a/misc.git
	git clone git@github.com:ernie18a/deprecated.git .deprecated
	git clone https://github.com/tmux-plugins/tpm /home/e/.G/.tmux_plugins_manager
	sed -i 's/https:\/\/github.com\/ernie18a\/dotfiles.git/git@github.com:ernie18a\/dotfiles.git/g' /home/e/.G/dotfiles/.git/config
	mkdir -p /home/e/.gemini
	mkdir -p /home/e/.claude
	mkdir -p /home/e/.hermes
	ln -snf /home/e/.G/dotfiles/home/.gitconfig /home/e/.gitconfig
	ln -snf /home/e/.G/dotfiles/home/.tmux.conf /home/e/.tmux.conf
	ln -snf /home/e/.G/dotfiles/home/.vimrc /home/e/.vimrc
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.gemini/GEMINI.md
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.claude/CLAUDE.md
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.hermes/SOUL.md
	chown -R e:e /home/e
		;;
  vm)
# vm zone
	# Replace this comment with the actual commands to be executed for Ampere
	;;
esac
chown -R e:e /home/e
