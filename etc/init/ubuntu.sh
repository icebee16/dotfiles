# XDG Base Directory
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
mkdir $HOME/.config $HOME/.cache $HOME/.local $HOME/.local/share
mkdir $HOME/.config/nvim
ln -s $HOME/dotfiles/vim/.vimrc $HOME/.config/nvim/init.vim

# apt install
apt update && apt upgrade -y
apt install -y tmux htop tree wget curl cmake gcc g++ build-essential ca-certificates software-properties-common

# zsh
apt install zsh
touch dotfiles/zsh/.zshrc_local
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
ln -s $HOME/dotfiles/zsh/.zshenv $HOME/
chsh $USER -s $(which zsh)

# pyenv
git clone https://github.com/yyuu/pyenv.git $HOME/.local/share/.pyenv
apt install -y make libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
pyenv install 3.6.6
pyenv global 3.6.6

# neovim
apt-add-repository ppa:neovim-ppa/stable
apt update
apt install -y neovim
pip install neovim

# ssh
ssh-keygen -t rsa -b 4096 -C $EMALE
chmod 600 $HOME/.ssh/id_rsa

# clean up
rm -f $HOME/.bash_history $HOME/.bash_logout $HOME/.bashrc
