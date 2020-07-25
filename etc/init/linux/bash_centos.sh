# XDG Base Directory
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share
mkdir -p $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME

# yum.comf
sudo sh -c "echo 'exclude=kernel*' >> /etc/yum.conf"

# apt install
sudo yum update -y
sudo yum install -y tmux htop tree wget curl cmake gcc g++ build-essential ca-certificates software-properties-common

# tmux
ln -s $HOME/dotfiles/tmux/.tmux.conf $HOME/

# zsh
sudo yum install zsh -y
touch $HOME/dotfiles/zsh/.zshrc_local
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
ln -s $HOME/dotfiles/zsh/.zshenv $HOME/
sudo chsh $USER -s $(which zsh)
