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

source os/common.sh
source os/${osType}.sh

update_package_manager
install_direnv
install_starship
install_fzf
install_stow
clone_dotfiles
run_stow_script
install_zsh_and_oh_my_zsh
instalL_python_and_pyenv
install_node_and_nvm
install_rust
install_go
install_nvim
install_apps

read -rp "Do you want to do X? (yes/no): " response
case $response in
[yY] | [yY][eE][sS])
	configure_git
	;;
*)
	echo "Not configuring git."
	;;
esac

chsh -s $(which zsh)
exec zsh -l
