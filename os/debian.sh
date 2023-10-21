update_package_manager() {
	sudo apt-get update
}

install_zsh_and_oh_my_zsh() {
	sudo apt-get install zsh
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

install_stow() {
	sudo apt-get install -y stow
}

install_kitty() {
	sudo apt-get install -y kitty
}

install_nvim() {
	pushd ~/bin || exit
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
	tar xzf nvim-linux64.tar.gz
	echo "nvim installed!"
	popd || exit
}
