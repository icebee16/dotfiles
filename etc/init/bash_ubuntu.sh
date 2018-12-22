# variance
read -p "give me uname" USER_NAME
echo $USER_NAME
read y

# XDG Base Directory
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share
for dir in $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME
do
    if [! -d $dir]; then
        mkdir $dir
    fi
done


# apt install
apt update && apt upgrade -y
apt install -y tmux htop tree wget curl cmake gcc g++ build-essential ca-certificates software-properties-common

# zsh
apt install zsh -y
touch $HOME/dotfiles/zsh/.zshrc_local
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
ln -s $HOME/dotfiles/zsh/.zshenv $HOME/
chsh $USER_NAME -s $(which zsh)
