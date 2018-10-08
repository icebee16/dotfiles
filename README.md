## gcloud
instanceの立ち上げ
```

```

## ssh gcloud(必要ならば)
project単位の鍵設定
## setup
### linux 16
root passwordの設定
```
sudo passwd root
```
#### zsh install まで
HOMEにて
```
sudp apt update
sudo apt upgrade
sudo apt install git build-essential tmux htop zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
git clone https://github.com/icebee16/dotfiles
touch dotfiles/zsh/.zshrc_local
ln -s $HOME/dotfiles/zsh/.zshenv $HOME/
ln -s $HOME/dotfiles/vim/.vimrc $HOME/
sudo chsh $USER -s $(which zsh)
```
再loginでzshから起動
```
rm -f .bash_history .bash_logout .bashrc
```

#### python環境構築

##### gpuなし
Anaconda3の導入
```
wget "https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh"
sh Anaconda3-5.2.0-Linux-x86_64.sh
```

zshを再起動してpythonのパスを変更
```
exec $SHELL -l
```
##### gpuあり(Tesla K80)
```
sudo apt update
sudp apt upgrade
# nvidia driver
sudo apt install -y nvidia-375 nvidia-settings

# CUDA Toolkit (9.0)
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo apt update
sudp apt upgrade
sudo apt install cuda=9.0.176-1
sudo apt update
sudp apt upgrade
```
cuDNNのファイルをダウンロード
https://developer.nvidia.com/rdp/cudnn-download
```
# cuDNN for 9.0
# runtime dev doc の3ファイル
[local]
gcloud compute copy-files <file_name> <instance>: --zone <zone>
[remote]
sudo dpkg -i <file_name>
echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64"' >> ~/dotfiles/zsh/.zshrc_local
echo 'export CUDA_HOME=/usr/local/cuda' >> ~/dotfiles/zsh/.zshrc_local
source $ZDOTDIR/.zshrc
```

pyenv環境の構築
```
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/dotfiles/zsh/.zshrc_local
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/dotfiles/zsh/.zshrc_local
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/dotfiles/zsh/.zshrc_local
source $ZDOTDIR/.zshrc
pyenv install anaconda3-5.3.0
pyenv global anaconda3-5.3.0
```

condaの設定
```
conda create -n py-gpu python=3.5
source $PYENV_ROOT/versions/anaconda3-5.3.0/bin/activate py-gpu
```

tensorflow 諸々を突っ込む
* 以降pip install は鬼門
* どうにかconda -c を駆使
```
conda install --upgrade conda
conda install tensorflow-gpu pillow h5py keras
```


#### Vim導入（7.4 > 8.1）
neovimを準備
```
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudp apt upgrade
sudo apt install neovim
conda install -c conda-forge neovim
```
vim本体を再インストール
```
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt upgrade
sudo apt install vim
```

dein plugin update

一度condaをディアクティベーションしたうえで
```
:call dein#update()
```

## ssh bitbucket (or github)
```
ssh-keygen -t rsa -b 4096 -C <e-mail>
chmod 600 .ssh/id_rsa
```
id_rsa.pubをほにゃほにゃしてbitbucketのsshに登録
```
ssh -T git@bitbuckt.org
```

## jupyter setup
```
conda install notebook ipykernel
ipython kernel install --user --name py-gpu
```
ついでにnbextensionsも
```
conda install -y -c conda-forge jupyter_contrib_nbextensions
conda install -y -c conda-forge jupyterthemes
jt -t chesterish -T -f roboto -fs 9 -tf merriserif -tfs 11 -nf ptsans -nfs 11 -dfs 8 -ofs 8
```

```
conda install numpy pandas matplotlib seaborn tensorflow-gpu pillow h5py keras jupyter scikit-learny
conda install -c anaconda scikit-image
conda install -c vfdev-5 image_dataset_viz
conda install -c conda-forge opencv jupyter_contrib_nbextensions jupyterthemes
```

