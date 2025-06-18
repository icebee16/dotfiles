#!/bin/bash

#----------------------#
#   Setup Script for   #
#     macOS (zsh)      #
#----------------------#

set -eu

#----------------------#
#     0. CONSTANTS     #
#----------------------#
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export PYENV_ROOT="$XDG_DATA_HOME/.pyenv"
export PIPX_HOME="$XDG_DATA_HOME/pipx"
export PIPX_BIN_DIR="$XDG_DATA_HOME/pipx/bin"
export PATH="$PYENV_ROOT/bin:$PIPX_BIN_DIR:$PATH"
export ZDOTDIR="$HOME/dotfiles/zsh"

#----------------------#
#     1. XDG DIRS      #
#----------------------#
echo "[Step 1] Creating XDG directories..."
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$PIPX_BIN_DIR"

#----------------------#
#     2. HOMEBREW      #
#----------------------#
echo "[Step 2] Checking Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed."
fi

brew update && brew upgrade && brew cleanup
brew install tmux htop tree wget fd fzf node git sheldon neovim pyenv pipx

#----------------------#
#     3. SYMLINKS      #
#----------------------#
echo "[Step 3] Creating symlinks..."
ln -sf "$ZDOTDIR/.zshenv" "$HOME/.zshenv"
ln -sf "$ZDOTDIR/.zprofile" "$HOME/.zprofile"
ln -sf "$ZDOTDIR/.zshrc" "$HOME/.zshrc"

ln -sf "$HOME/dotfiles/nvim" "$XDG_CONFIG_HOME/nvim"

#----------------------#
#     4. PYTHON ENV    #
#----------------------#
echo "[Step 4] Installing Python with pyenv..."
if [ ! -d "$PYENV_ROOT" ]; then
  git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT"
fi

eval "$(pyenv init -)"

if ! pyenv versions | grep -q 3.11.9; then
  pyenv install 3.11.9
fi
pyenv global 3.11.9

# Upgrade pip
pip install --upgrade pip

# Install pipx tools
pipx install poetry
pipx install uv
pipx install flake8
pipx install kaggle

# Poetry settings
poetry config virtualenvs.in-project true
mkdir -p "$ZDOTDIR/.zfunc"
poetry completions zsh > "$ZDOTDIR/.zfunc/_poetry"

#----------------------#
#     5. NEOVIM ENV    #
#----------------------#
echo "[Step 5] Installing Neovim dependencies..."
pip install pynvim
npm install -g neovim

#----------------------#
#     6. SHELDON       #
#----------------------#
echo "[Step 6] Initializing sheldon..."
mkdir -p "$XDG_CONFIG_HOME/sheldon"
ln -sf "$HOME/dotfiles/zsh/.zsh_plugins.toml" "$XDG_CONFIG_HOME/sheldon/plugins.toml"
sheldon lock --update

#----------------------#
#     7. FINISH        #
#----------------------#
echo "[Done] Initial setup complete! Please restart your terminal."
