#!/bin/bash

update_package_manager() {
	sudo apt-get update
}

install_zsh_and_oh_my_zsh() {
	sudo apt-get install -y zsh
	install_oh_my_zsh
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

install_pyenv_requirements() {
	# prevent tzdata config popup
	sudo DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
	sudo apt-get install -y make \
		build-essential \
		libssl-dev \
		zlib1g-dev \
		libbz2-dev \
		libreadline-dev \
		libsqlite3-dev \
		wget \
		curl \
		llvm \
		libncursesw5-dev \
		xz-utils \
		tk-dev \
		libxml2-dev \
		libxmlsec1-dev \
		libffi-dev \
		liblzma-dev
}
