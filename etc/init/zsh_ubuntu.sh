# ================== #
# XDG Base Directory #
# ================== #
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share

# ======== #
# IntelMKL #
# ======== #
# https://software.intel.com/en-us/articles/installing-intel-free-libs-and-python-apt-repo
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo wget https://apt.repos.intel.com/setup/intelproducts.list -O /etc/apt/sources.list.d/intelproducts.list
sudo apt update
sudo apt install -y intel-mkl-2019.3-062

# ====== #
# python #
# ====== #
# >> pyenv
git clone https://github.com/yyuu/pyenv.git $XDG_DATA_HOME/.pyenv
sudo apt install -y make libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
set +e
source $ZDOTDIR/.zshrc
set -e
pyenv install 3.6.8
pyenv global 3.6.8
pip install -U pip

# >> neovim
mkdir $XDG_CONFIG_HOME/nvim
ln -s $HOME/dotfiles/vim/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
sudo apt-add-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install -y neovim
pip install neovim
pip install flake8

# >> jupyter
pip install jupyter
pip install jupyter_contrib_nbextensions
pip install jupyterthemes
jt -t chesterish -T -f roboto -fs 9 -tf merriserif -tfs 11 -nf ptsans -nfs 11 -dfs 8 -ofs 8

# >> kaggle
pip install kaggle

# >> numpy, scipy (IntelMKL build)
touch $HOME/.numpy-site.cfg
echo '[mkl]' >> $HOME/.numpy-site.cfg
echo 'library_dirs = /opt/intel/mkl/lib/intel64' >> $HOME/.numpy-site.cfg
echo 'include_dirs = /opt/intel/mkl/include' >> $HOME/.numpy-site.cfg
echo 'mkl_libs = mkl_rt' >> $HOME/.numpy-site.cfg
echo 'lapack_libs =' >> $HOME/.numpy-site.cfg
pip install --no-binary :all: numpy
pip install --no-binary :all: scipy

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
