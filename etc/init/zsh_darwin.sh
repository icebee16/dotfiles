# ================== #
# XDG Base Directory #
# ================== #
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share

# ====== #
# python #
# ====== #
# >> pyenv
git clone https://github.com/yyuu/pyenv.git $XDG_DATA_HOME/.pyenv
# sudo apt install -y make libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
set +e
source $ZDOTDIR/.zshrc
set -e
pyenv install 3.6.10 # for kaggle
pyenv install 3.7.7
pyenv global 3.7.7
pip install -U pip

# >> poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
mkdir $ZDOTDIR/.zfunc
poetry completions zsh > $ZDOTDIR/.zfunc/_poetry

# >> pipx
pip install pipx
pipx ensurepath

# >> flake8
pipx install flake8

# >> kaggle
mkdir $XDG_CONFIG_HOME/kaggle
pipx install kaggle

# >> neovim
mkdir $XDG_CONFIG_HOME/nvim
ln -s $HOME/dotfiles/vim/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
brew install neovim
pip install pynvim
npm install -g neovim

# >> jupyter
pip install jupyter
pip install jupyter_contrib_nbextensions
pip install jupyterthemes
jt -t chesterish -T -f roboto -fs 9 -tf merriserif -tfs 11 -nf ptsans -nfs 11 -dfs 8 -ofs 8

# === #
# ssh #
# === #
echo "give me e-mail"
read EMAIL
ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -b 4096 -C $EMAIL
chmod 600 $HOME/.ssh/id_rsa

# ======== #
# clean up #
# ======== #
rm -f $HOME/.bash_history $HOME/.bash_logout $HOME/.bashrc
