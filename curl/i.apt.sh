#!/bin/bash
	timedatectl set-timezone Asia/Taipei
#	rm -rf ~/.* /home/e/.* /home/ubuntu/.*
 	apt-get purge -y --allow-remove-essential needrestart iptables* ufw* apparmor* firewall* unattended-upgrades # git* python3-venv python3-pip
#	apt-get purge -y ufw* apparmor* needrestart unattended-upgrades
	apt-get update ; apt-get install -yq ripgrep rsync apt-utils bash-completion tmux vim bsdmainutils apt-transport-https dialog 
	curl -LsSf https://astral.sh/uv/install.sh | sh
	cp ~/.local/bin/* /usr/local/bin/
	echo ServerAliveInterval\ 30 >> /etc/ssh/ssh_config
	echo StrictHostKeyChecking\ no >> /etc/ssh/ssh_config
	echo TCPKeepAlive\ no >> /etc/ssh/ssh_config
	echo ForwardAgent\ yes >> /etc/ssh/ssh_config
	echo ClientAliveInterval\ 60 >> /etc/ssh/sshd_config
	echo ClientAliveCountMax\ 3 >> /etc/ssh/sshd_config
	swapoff -a ; sed -i '/swap/ s/^/#/' /etc/fstab
 	echo "e ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
 	echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
	curl -fsSL https://gitlab.com/ernie18a/dotfiles/-/raw/main/curl/e.brc.n.auth.sh | bash
	echo 'source /dev/stdin <<< "$(curl -Ls https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/.bash_profile)"' |tee ~/.bash_profile /home/e/.bash_profile /home/ubuntu/.bash_profile
case "$1" in
  wsl)
	echo wsl
	curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -  # nodejs
	apt-get update ; apt-get install -yq python3-pip python3-venv dos2unix file jq software-properties-common tree unzip autossh sshpass nodejs # wsl
	npm install -g @google/gemini-cli # firebase-admin firebase-tools
#	add-apt-repository ppa:git-core/ppa
	apt-get update ; apt-get install -yq git
	apt-get autoremove -y ; dpkg -l | grep "^rc" | awk "{print\$2}" | xargs apt-get purge -y
	export WIN_USER=$(ls /mnt/c/Users |grep -iv "All\|Default\|desktop.ini\|Public\|USER\|Administrator\|super")
	export WIN_USER_DIR=/mnt/c/Users/$WIN_USER
	export WIN_USER_DL=/mnt/c/Users/$WIN_USER/Downloads
	unzip $WIN_USER_DL/ernie-master.zip
#	unzip $WIN_USER_DL/55h-main.zip
	timedatectl set-timezone Asia/Taipei
	# /root/.ssh
	mkdir ~/.ssh
	cat ernie-master/.ssh/id_rsa > ~/.ssh/id_rsa
	cat ernie-master/.ssh/id_rsa.pub > ~/.ssh/id_rsa.pub
	chmod 0700 ~/.ssh
	chmod 0600 ~/.ssh/id_rsa
	chmod 0644 ~/.ssh/id_rsa.pub
#	e/.ssh
	cp -rf ~/.ssh /home/e/.ssh
	chmod 0700 /home/e/.ssh
	chmod 0600 /home/e/.ssh/id_rsa
	chmod 0644 /home/e/.ssh/id_rsa.pub
#	/home/e/
	mkdir /home/e/.G/
	cd /home/e/.G/
#	git clone git@gitlab.com:ernie18a/bs.git
#	git clone git@gitlab.com:ernie18a/fbdb.git
#	git clone git@gitlab.com:ernie18a/fbf.git
	git clone git@gitlab.com:ernie18a/dotfiles.git
	git clone git@gitlab.com:ernie18a/misc.git
 	git clone git@gitlab.com:ernie18a/411d3.git .411d3
 	git clone git@gitlab.com:ernie18a/private.git .private
 	git clone git@gitlab.com:ernie18a/private2.git .private2
#	git clone git@gitlab.com:ernie18a/llnp.git
#	git clone git@gitlab.com:ernie18a/pip3.install
	git clone https://github.com/tmux-plugins/tpm /home/e/.G/.tmux_plugins_manager      
	sed -i 's/https:\/\/gitlab.com\/ernie18a\/dotfiles.git/git@gitlab.com:ernie18a\/dotfiles.git/g' /home/e/.G/dotfiles/.git/config
	ln -snf /home/e/.G/dotfiles/home/.bash_profile /home/e/.bash_profile
	ln -snf /home/e/.G/dotfiles/home/.bash_profile /home/e/.bashrc
	ln -snf /home/e/.G/dotfiles/home/.gitconfig /home/e/.gitconfig
	ln -snf /home/e/.G/dotfiles/home/.tmux.conf /home/e/.tmux.conf
	ln -snf /home/e/.G/dotfiles/home/.vimrc /home/e/.vimrc
	mkdir -p /home/e/.gemini
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.gemini/GEMINI.md
	ln -snf /home/e/.G/dotfiles/home/settings.json /home/e/.gemini/settings.json
	chown -R e:e /home/e
#	cat /home/e/.G/dotfiles/home/.hyper.js > $WIN_USER_DIR/AppData/Roaming/Hyper/.hyper.js
    ;;
  oci)
    # Replace this comment with the actual commands to be executed for Ampere
    ;;
  vm)
	echo vm
#	sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
	apt-get update ; apt-get install -yq file jq software-properties-common tree
#	add-apt-repository ppa:git-core/ppa
	apt-get update ; apt-get install -yq git open-vm-tools
	apt-get autoremove -y ; dpkg -l | grep "^rc" | awk "{print\$2}" | xargs apt-get purge -y
	echo 'network: {config: disabled}' >> /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
    ;;
  *)
    # If an unknown argument is passed, print an error message and exit
    echo "Usage: run.sh [wsl|ampere|vm]"
    exit 1
    ;;
esac
# endding
#	cp -rf ~/.ssh /home/e/.ssh
#	cp -rf ~/.ssh /home/ubuntu/.ssh
	chown -R e:e /home/e ; chown -R ubuntu:ubuntu /home/ubuntu
