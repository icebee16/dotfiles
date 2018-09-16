# gcloud
# ssh
# setup
## linux 18
```まずは
sudo passwd root
```
```$HOMEにて
sudo apt update  
sudo apt install git build-essential tmux htop zsh  
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh  
git clone https://github.com/icebee16/dotfiles
ln -s $HOME/dotfiles/zsh/.zshenv $HOME/.zshenv
ln -s $HOME/dotfiles/vim/.vimrc $HOME/.vimrc
chsh -s /usr/bin/zsh
exec $SHELL -l
```

wget [anaconda3]

sh [anaconda3]
