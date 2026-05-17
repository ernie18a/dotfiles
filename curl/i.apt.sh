#!/bin/bash
	timedatectl set-timezone Asia/Taipei
#	rm -rf ~/.* /home/e/.* /home/ubuntu/.*
 	apt-get purge -y --allow-remove-essential needrestart iptables* ufw* apparmor* firewall* unattended-upgrades # git* python3-venv python3-pip
#	apt-get purge -y ufw* apparmor* needrestart unattended-upgrades
#	apt-get update ; apt-get install -yq  rsync apt-utils bash-completion tmux vim bsdmainutils apt-transport-https dialog 
	apt-get update ; apt-get install -yq acl adb apt-transport-https apt-utils autossh bash-completion bsdmainutils build-essentia claude-code cmake dialog dos2unix file hwdata jq linux-tools-generic nodejs ripgrep rsync software-properties-common sshpass tmux tree unzip usbutils vim
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
	echo 'source /dev/stdin <<< "$(curl -Ls https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile)"' |tee ~/.bash_profile /home/e/.bash_profile /home/ubuntu/.bash_profile
case "$1" in
  wsl)
	echo wsl
	sudo install -d -m 0755 /etc/apt/keyrings
    sudo curl -fsSL https://downloads.claude.ai/keys/claude-code.asc -o /etc/apt/keyrings/claude-code.asc
	echo "deb [signed-by=/etc/apt/keyrings/claude-code.asc] https://downloads.claude.ai/claude-code/apt/stable stable main" | sudo tee /etc/apt/sources.list.d/claude-code.list
	curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -  # nodejs
#	apt-get update ; apt-get install -yq cmake build-essentia linux-tools-generic hwdata adb usbutils ripgrep claude-code  dos2unix file jq software-properties-common tree unzip autossh sshpass nodejs #  python3-pip python3-venv
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
	cat ernie-master/.ssh/id_ed25519 > ~/.ssh/id_ed25519
	cat ernie-master/.ssh/id_ed25519.pub > ~/.ssh/id_ed25519.pub
	chmod 0700 ~/.ssh
	chmod 0600 ~/.ssh/id_ed25519
	chmod 0644 ~/.ssh/id_ed25519.pub
#	e/.ssh
	cp -rf ~/.ssh /home/e/.ssh
	chmod 0700 /home/e/.ssh
	chmod 0600 /home/e/.ssh/id_ed25519
	chmod 0644 /home/e/.ssh/id_ed25519.pub
#	/home/e/
	mkdir /home/e/.G/
	cd /home/e/.G/
#	git clone git@github.com:ernie18a/bs.git
#	git clone git@github.com:ernie18a/fbdb.git
#	git clone git@github.com:ernie18a/fbf.git
	git clone git@github.com:ernie18a/dotfiles.git
	git clone git@github.com:ernie18a/misc.git
 	git clone git@github.com:ernie18a/private.git .private
#	git clone git@github.com:ernie18a/llnp.git
#	git clone git@github.com:ernie18a/pip3.install
	git clone https://github.com/tmux-plugins/tpm /home/e/.G/.tmux_plugins_manager      
	sed -i 's/https:\/\/github.com\/ernie18a\/dotfiles.git/git@github.com:ernie18a\/dotfiles.git/g' /home/e/.G/dotfiles/.git/config
	ln -snf /home/e/.G/dotfiles/home/.bash_profile /home/e/.bash_profile
	ln -snf /home/e/.G/dotfiles/home/.bash_profile /home/e/.bashrc
	ln -snf /home/e/.G/dotfiles/home/.gitconfig /home/e/.gitconfig
	ln -snf /home/e/.G/dotfiles/home/.tmux.conf /home/e/.tmux.conf
	ln -snf /home/e/.G/dotfiles/home/.vimrc /home/e/.vimrc
	mkdir -p /home/e/.gemini
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.gemini/GEMINI.md
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.claude/CLAUDE.md
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
