# variance
echo $USER
echo "give me uname : "
read USER_NAME

# XDG Base Directory
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share
mkdir -p $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME

# apt install
sudo apt update && sudo apt upgrade -y
sudo apt install -y tmux htop tree wget curl cmake gcc g++ build-essential ca-certificates software-properties-common

# zsh
sudo apt install zsh -y
touch $HOME/dotfiles/zsh/.zshrc_local
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
ln -s $HOME/dotfiles/zsh/.zshenv $HOME/
sudo chsh $USER -s $(which zsh)
