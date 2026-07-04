#!/bin/bash
case "$1" in
  default)
	# default zone
	timedatectl set-timezone Asia/Taipei
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
	# echo 'source /dev/stdin <<< "$(curl -Ls https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile)"' | tee ~/.bash_profile ~/.bashrc /home/e/.bash_profile /home/e/.bashrc /home/ubuntu/.bash_profile /home/ubuntu/.bashrc
	echo 'source /dev/stdin <<< "$(curl -Ls "https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile?v=$(date +%s)")"' | tee ~/.bash_profile ~/.bashrc /home/e/.bash_profile /home/e/.bashrc /home/ubuntu/.bash_profile /home/ubuntu/.bashrc
	curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.ssh.pub.sh | bash
	;;
  dev)
	# dev zone
	apt-get install -yq \
		build-essential cargo pkg-config rustc rustfmt \
		acl cmake
	;;
  wsl)
# wsl zone
		export WIN_USER=$(ls /mnt/c/Users | grep -iv "All\|Default\|desktop.ini\|Public\|USER\|Administrator\|super")
		export WIN_USER_DL=/mnt/c/Users/$WIN_USER/Downloads
	unzip "$WIN_USER_DL/ernie-master.zip"
	cat ernie-master/.ssh/id_ed25519 > ~/.ssh/id_ed25519
	chmod 0600 ~/.ssh/id_ed25519
	cp -f ~/.ssh/id_ed25519 /home/e/.ssh/id_ed25519
	chmod 0600 /home/e/.ssh/id_ed25519
	;;
  vm)
# vm zone
	# Replace this comment with the actual commands to be executed for Ampere
	;;
esac
