# variance
read -p "give me e-mail" EMAIL

# XDG Base Directory
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share

# pyenv
git clone https://github.com/yyuu/pyenv.git $XDG_DATA_HOME/.pyenv
apt install -y make libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
pyenv install 3.6.6
pyenv global 3.6.6

# neovim
mkdir $XDG_CONFIG_HOME/nvim
ln -s $HOME/dotfiles/vim/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
apt-add-repository ppa:neovim-ppa/stable
apt update
apt install -y neovim
pip install neovim

# ssh
ssh-keygen -t rsa -b 4096 -C $EMALE
chmod 600 $HOME/.ssh/id_rsa

# clean up
rm -f $HOME/.bash_history $HOME/.bash_logout $HOME/.bashrc
exit
