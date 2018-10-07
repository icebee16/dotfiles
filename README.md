## gcloud
instanceの立ち上げ
## ssh (必要ならば)
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
sudp apt upgrade
sudo apt update
sudo apt install git build-essential tmux htop zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
git clone https://github.com/icebee16/dotfiles
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
##### gpuあり
```

```


#### Vim導入（7.4 > 8.1）
```
sudo add-apt-repository ppa:jonathonf/vim
sudo apt upgrade
sudo apt update
sudo apt install vim
```

dein plugin update
```
:call dein#update()
```

