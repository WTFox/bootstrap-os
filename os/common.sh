#!/bin/bash

clone_dotfiles() {
	git clone https://github.com/wtfox/dotfiles.git ~/dotfiles
}

run_stow_script() {
	pushd ~/dotfiles || exit
	rm ~/.bashrc
	rm ~/.zshrc
	if [[ "$osType" == "mac" ]]; then
		./stow_mac.sh
	else
		./stow_linux.sh
	fi
	popd || exit
}

install_oh_my_zsh() {
	KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

install_fzf() {
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --key-bindings --completion --no-update-rc
}

instalL_python_and_pyenv() {
	install_pyenv_requirements
	curl https://pyenv.run | zsh
	export PYENV_ROOT="$HOME/.pyenv"
	command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
	pyenv install 3.12.0
	pyenv global 3.12.0

	python3 -m pip install --upgrade pip
	python3 -m pip install --user pipx
	python3 -m pipx ensurepath

	pipx install poetry
	pipx install black
	pipx install flake8
	pipx install isort
	pipx install mypy
}

install_node_and_nvm() {
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	nvm install node
	nvm use node

	npm install -g yarn
	npm install -g typescript
	npm install -g typescript-language-server
	npm install -g eslint
	npm install -g prettier
	npm install -g bash-language-server
	npm install -g particle-cli
}

install_direnv() {
	curl -sfL https://direnv.net/install.sh | bash
}

install_starship() {
	curl -sS https://starship.rs/install.sh | sh -s -- -y
}

install_rust() {
	curl https://sh.rustup.rs -sSf | sh -s -- -y

	# install cargo
	cargo install --locked --git https://github.com/sxyazi/yazi.git
}

install_pyenv_requirements() {
	# overriden in os files
	pass
}

install_golang() {
	# overriden in os files
	pass
}

install_apps() {
	# overriden in os files
	pass
}

configure_git() {
	gh auth login
	gh auth setup-git
}
