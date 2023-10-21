update_package_manager() {
	sudo pacman -Syu
}

install_zsh_and_oh_my_zsh() {
	sudo pacman -S zsh
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

install_stow() {
	sudo pacman -S stow
}

install_kitty() {
	sudo pacman -S kitty
}

install_nvim() {
	pushd ~/bin || exit
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
	tar xzf nvim-linux64.tar.gz
	echo "nvim installed!"
	popd || exit
}
