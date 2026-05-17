timedatectl set-timezone Asia/Taipei
apt-get purge -y --allow-remove-essential \
	needrestart ufw* apparmor* firewall* \
	unattended-upgrades landscape-common ubuntu-advantage-tools \
	cloud-init popularity-contest ubuntu-report apport whoopsie fwupd
apt-get update
apt-get install -yq \
	apt-transport-https rsync software-properties-common \
	sshpass tmux vim autossh bash-completion git jq file \
	tree ffmpeg
install -d -m 0755 /etc/apt/keyrings
curl -fsSL https://downloads.claude.ai/keys/claude-code.asc -o /etc/apt/keyrings/claude-code.asc
echo "deb [signed-by=/etc/apt/keyrings/claude-code.asc] https://downloads.claude.ai/claude-code/apt/stable stable main" | tee /etc/apt/sources.list.d/claude-code.list
curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
apt-get update ; apt-get install -yq nodejs claude-code
npm install -g @google/gemini-cli
curl -LsSf https://astral.sh/uv/install.sh | sh
cp ~/.local/bin/* /usr/local/bin/
apt-get autoremove -y ; dpkg -l | grep "^rc" | awk '{print$2}' | xargs apt-get purge -y
echo ServerAliveInterval\ 30 >> /etc/ssh/ssh_config
echo StrictHostKeyChecking\ no >> /etc/ssh/ssh_config
echo TCPKeepAlive\ no >> /etc/ssh/ssh_config
echo ForwardAgent\ yes >> /etc/ssh/ssh_config
echo ClientAliveInterval\ 60 >> /etc/ssh/sshd_config
echo ClientAliveCountMax\ 3 >> /etc/ssh/sshd_config
swapoff -a ; sed -i '/swap/ s/^/#/' /etc/fstab
echo "e ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo 'source /dev/stdin <<< "$(curl -Ls https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile)"' | tee ~/.bash_profile ~/.bashrc /home/e/.bash_profile /home/e/.bashrc /home/ubuntu/.bash_profile /home/ubuntu/.bashrc
touch ~/.hushlogin /home/e/.hushlogin /home/ubuntu/.hushlogin
rm -f /etc/update-motd.d/50-motd-news
chown -R e:e /home/e ; chown -R ubuntu:ubuntu /home/ubuntu
if [ "$1" = "wsl" ]; then
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
	git clone git@github.com:ernie18a/private.git .private
	git clone https://github.com/tmux-plugins/tpm /home/e/.G/.tmux_plugins_manager
	sed -i 's/https:\/\/github.com\/ernie18a\/dotfiles.git/git@github.com:ernie18a\/dotfiles.git/g' /home/e/.G/dotfiles/.git/config
	ln -snf /home/e/.G/dotfiles/home/.gitconfig /home/e/.gitconfig
	ln -snf /home/e/.G/dotfiles/home/.tmux.conf /home/e/.tmux.conf
	ln -snf /home/e/.G/dotfiles/home/.vimrc /home/e/.vimrc
	mkdir -p /home/e/.gemini
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.gemini/GEMINI.md
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.claude/CLAUDE.md
fi
