# base
apt update && apt upgrade -y
apt install -y tmux htop tree wget curl cmake gcc g++ build-essential ca-certificates software-properties-common

# pyenv
git clone https://github.com/yyuu/pyenv.git $XDG_DATA_HOME/.pyenv
apt install -y make libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

