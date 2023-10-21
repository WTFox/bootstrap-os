update_package_manager() {
	if ! command -v brew &>/dev/null; then
		echo "brew could not be found"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		brew update
	fi
}

install_zsh_and_oh_my_zsh() {
	brew install zsh
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

install_stow() {
	brew install stow
}

install_kitty() {
	brew install kitty
}

install_nvim() {
	pushd ~/bin || exit
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
	tar xzf nvim-macos.tar.gz
	echo "nvim installed!"
	popd || exit
}
