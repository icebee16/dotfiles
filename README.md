# gcloud
# ssh
# setup
## linux 18
まずは
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
再接続を行えば完了  
Vimの更新
```
sudo add-apt-repository ppa:jonathonf
sudo apt update
sudo apt install vim
```

wget [anaconda3]

sh [anaconda3]
