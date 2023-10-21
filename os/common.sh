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

install_pyenv_requirements() {
	# overriden in os files
	pass
}

instalL_python_and_pyenv() {
	install_pyenv_requirements
	curl https://pyenv.run | zsh
	export PYENV_ROOT="$HOME/.pyenv"
	command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
	pyenv install 3.12.0
	pyenv global 3.12.0
}

install_node_and_nvm() {
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	nvm install node
	nvm use node
}

install_direnv() {
	curl -sfL https://direnv.net/install.sh | bash
}

install_starship() {
	curl -sS https://starship.rs/install.sh | sh -s -- -y
}
