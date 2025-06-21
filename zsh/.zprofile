# ~/.zprofile

# pyenv のパス（ログイン時に通す）
export PYENV_ROOT="$XDG_DATA_HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# homebrew in Darwin
export PATH="/opt/homebrew/bin:$PATH"

# load secrets if available
for file in "$XDG_CONFIG_HOME"/secrets/*.env; do
  [ -f "$file" ] && source "$file"
done
