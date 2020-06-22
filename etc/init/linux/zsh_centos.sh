# ================== #
# XDG Base Directory #
# ================== #
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share

LD_LIBRARY_PATH=
LIBRARY_PATH=

# ====== #
# python #
# ====== #
# >> pyenv
sudo yum install gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel
git clone https://github.com/pyenv/pyenv.git $XDG_DATA_HOME/.pyenv
set +e
source $ZDOTDIR/.zshrc
set -e
pyenv install 3.7.7
pyenv global 3.7.7
pip install -U pip

# >> pipx
pip install pipx
pipx ensurepath
pipx install flake8

# ====== #
# neovim #
# ====== #
# >> neovim config setup
mkdir $XDG_CONFIG_HOME/nvim
ln -s $HOME/dotfiles/vim/.vimrc $XDG_CONFIG_HOME/nvim/init.vim

# >> latest vim install
sudo yum install -y curl git make gcc ncurses-devel
git clone https://github.com/vim/vim.git $XDG_DATA_HOME/.vim
cd $XDG_DATA_HOME/.vim
./configure \
  --disable-selinux \
  --enable-cscope \
  --enable-fontset \
  --enable-gpm \
  --enable-multibyte \
  --enable-rubyinterp \
  --enable-xim
sudo make && sudo make install
echo 'export PATH="/usr/local/bin:$PATH"' >> $ZDOTDIR/.zshrc_local

# >> neovim build & install
sudo yum -y install ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip patch
git clone https://github.com/neovim/neovim.git $XDG_DATA_HOME/.neovim
cd $XDG_DATA_HOME/.neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
cd

# >> nodejs
sudo yum remove -y nodejs npm
curl -sL https://rpm.nodesource.com/setup_12.x | sudo bash -
sudo yum install -y nodejs
sudo npm install -g neovim

# >> pynvim
pip install pynvim

# >> yarn
sudo npm install -g yarn
/usr/local/bin/nvim -c "CocInstall -sync coc-json coc-python coc-ultisnips | q"
