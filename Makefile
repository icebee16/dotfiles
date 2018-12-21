# deploy
deploy:
	apt update
	apt upgrade -y
	ln -s $HOME/dotfiles/zsh/.zshenv $HOME/
	ln -s $HOME/dotfiles/tmux/.tmux.conf $HOME/
	ln -s $HOME/dotfiles/vim/.vimrc $XDG_CONFIG_HOME/nvim/init.vim

# init
init:
	@$(foreach val, $(wildcard ./etc/init/*.sh), bash $(val);)
