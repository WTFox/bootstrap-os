#!/bin/bash

clone_dotfiles() {
	git clone https://github.com/wtfox/dotfiles.git ~/dotfiles
}

run_stow_script() {
	cd ~/dotfiles && ./stow_${osType}
}

instalL_python_and_pyenv() {
	curl https://pyenv.run | bash
	pyenv install 3.12.0
	pyenv global 3.12.0
}

install_node_and_nvm() {
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
	nvm install node
	nvm use node
}
