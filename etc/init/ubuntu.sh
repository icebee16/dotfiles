# XDG Base Directory
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
mkdir $HOME/.config $HOME/.cache $HOME/.local $HOME/.local/share
mkdir $XDG_CONFIG_HOME/nvim
ln -s $HOME/dotfiles/vim/.vimrc $XDG_CONFIG_HOME/nvim/init.vim

# base
apt update && apt upgrade -y
apt install -y tmux htop tree wget curl cmake gcc g++ build-essential ca-certificates software-properties-common

# zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
touch dotfiles/zsh/.zshrc_local

# pyenv
git clone https://github.com/yyuu/pyenv.git $XDG_DATA_HOME/.pyenv
apt install -y make libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
pyenv install 3.6.6
pyenv global 3.6.6

#neovim
sudo apt-add-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install -y neovim
pip install neovim
