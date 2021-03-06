# deploy
.PHONY: deploy init
deploy:
	@apt update
	@apt upgrade -y
	ln -s $(HOME)/dotfiles/zsh/.zshenv $(HOME)/
	ln -s $(HOME)/dotfiles/tmux/.tmux.conf $(HOME)/
	ln -s $(HOME)/dotfiles/vim/.vimrc $(XDG_CONFIG_HOME)/nvim/init.vim

# init
init:
	@bash etc/init/bash_init.sh
	@zsh etc/init/zsh_init.sh
