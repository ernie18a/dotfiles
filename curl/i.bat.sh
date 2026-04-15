#!/bin/bash

# Check if 'yum' is installed
if which yum &>/dev/null; then
    echo "Using yum"
    
    # Install GCC using yum
    sudo yum install -y gcc
    
    # Download and install Rust using curl
    curl https://sh.rustup.rs -sSf | sh
    
    # Note: Uncomment the next lines if you need EPEL repository and Cargo installed via yum
    # sudo yum install -y epel-release
    # sudo yum install -y cargo 1>/dev/null
    
    # Install 'bat' using Cargo
    cargo install bat &>/dev/null
    
    # Copy 'bat' binary to /bin for global access
    sudo cp ~/.cargo/bin/bat /bin/
else
    echo "Using apt-get"
    
    # Update package lists for upgrades and new packages
    sudo apt-get update -y 1>/dev/null
    
    # Install 'bat' using apt-get
    sudo apt-get install bat -y 1>/dev/null
	sudo mv /bin/batcat /bin/bat
    # Note: Uncomment the next line if you want to create a symlink in ~/.local/bin
    # mkdir -p ~/.local/bin
    # sudo ln -s /usr/bin/batcat /usr/bin/bat 1>/dev/null
fi







# which yum &>/dev/null
# if [ $? == 0 ]
# then
# yum install -y gcc
# curl https://sh.rustup.rs -sSf | sh
# # sudo yum install -y epel-release
# # sudo yum install -y cargo 1>/dev/null
# cargo install bat &>/dev/null
# sudo cp ~/.cargo/bin/bat /bin/
# else
# sudo apt-get update -y 1>/dev/null
# sudo apt-get install bat -y 1>/dev/null
# # mkdir -p ~/.local/bin
# sudo ln -s /usr/bin/batcat /usr/bin/bat 1>/dev/null
# fi
