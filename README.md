## gcloud
1.instanceの立ち上げ
## ssh
1.project単位の鍵設定
## setup
### linux 16
root passwordの設定
```
sudo passwd root
```

HOMEにて
```
sudo apt update
sudo apt install git build-essential tmux htop zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
git clone https://github.com/icebee16/dotfiles
ln -s $HOME/dotfiles/zsh/.zshenv $HOME/
ln -s $HOME/dotfiles/vim/.vimrc $HOME/
sudo chsh $USER -s $(which zsh)
```
再loginでzshから起動

Vim7.4 > 8.1
```
sudo add-apt-repository ppa:jonathonf
sudo apt update
sudo apt install vim
```

dein plugin update
```
:call dein#update()
```

Anaconda3の導入
```
wget "https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh"
sh Anaconda3-5.2.0-Linux-x86_64.sh
```

```

```

