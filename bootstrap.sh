#!/bin/bash

# Prompt for sudo password upfront and keep the sudo session alive for subsequent sudo commands
# While the script is running, refresh the sudo session in the background
echo "Please enter your sudo password for setup:"
sudo -v
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

# Determine OS type
osType=""
if [[ "$OSTYPE" == "darwin"* ]]; then
	osType="mac"
elif [[ -e "/etc/arch-release" ]]; then
	osType="arch"
elif [[ "$(cat /etc/os-release | grep 'ID_LIKE' | cut -d'=' -f2)" == "debian" ]]; then
	osType="debian"
else
	echo "Unsupported OS type."
	exit 1
fi

# TODO: maybe have an os init script that runs brew update or apt-get update
if [[ "$osType" == "mac" ]]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
elif [[ "$osType" == "debian" ]]; then
	sudo apt-get update
elif [[ "$osType" == "arch" ]]; then
	sudo pacman -Syu
fi

# Source common and OS-specific functions
source os/common.sh
source os/${osType}.sh

# Start setup
update_package_manager
install_zsh_and_oh_my_zsh
install_stow
clone_dotfiles
run_stow_script
install_kitty
install_neovim
instalL_python_and_pyenv
install_node_and_nvm
# install direnv
# install fzf

echo "Setup complete!"
