# Created by newuser for 5.5.1

#=========================#
#   grobal PATH setting   #
#=========================#
## XDG Base Directory ##
# https://wiki.archlinux.jp/index.php/XDG_Base_Directory_%E3%82%B5%E3%83%9D%E3%83%BC%E3%83%88
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
## kaggle API ##
# https://github.com/Kaggle/kaggle-api
export KAGGLE_CONFIG_DIR="$XDG_CONFIG_HOME/kaggle"

#==============#
#   autoload   #
#==============#
## completion
autoload -Uz compinit
fpath+=$ZDOTDIR/.zfunc
compinit

autoload -Uz bashcompinit
bashcompinit

## colors
autoload -Uz colors
colors

#====================#
#   python setting   #
#====================#
## pyenv ##
# https://github.com/pyenv/pyenv
export PYENV_ROOT="$XDG_DATA_HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

## poetry ##
export PATH="$HOME/.poetry/bin:$PATH"

## pipx ##
export PATH="$HOME/.local/bin:$PATH"
eval "$(register-python-argcomplete pipx)"

#=========================#
#   config file loading   #
#=========================#
## OS type config file ##
[ -f $ZDOTDIR/.zshrc_`uname` ] && . $ZDOTDIR/.zshrc_`uname`
## local config file ##
[ -f $ZDOTDIR/.zshrc_local ] && . $ZDOTDIR/.zshrc_local

#====================#
#   Option setting   #
#====================#
## completion ##
setopt auto_param_slash
setopt mark_dirs
setopt list_types
setopt list_packed
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt magic_equal_subst
setopt always_last_prompt
setopt complete_in_word
setopt globdots
## history ##
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt extended_history
setopt inc_append_history
## change directry ##
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
## etc
setopt ignore_eof
setopt correct
setopt no_beep
### zstyle ###
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

#============#
#   PROMPT   #
#============#
if [ -n "$SSH_CONNECTION" ]; then
	PROMPT="%{${fg[cyan]}%}[%n]%{${reset_color}%}@%{${fg[red]}%}[%m]%{${reset_color}%} %# "
	RPROMPT="%{${fg[white]}%}[%~]%{${reset_color}%}"
else
	PROMPT="%{${fg[cyan]}%}[%n]%{${reset_color}%}@%{${fg[green]}%}[%m]%{${reset_color}%} %# "
	RPROMPT="%{${fg[white]}%}[%~]%{${reset_color}%}"
fi

#====================#
#   alias and hash   #
#====================#
## key bind ##
bindkey -e
## alias ##
alias 'rm'='rm -i'
alias 'cp'='cp -i'
alias 'mv'='mv -i'
alias 'vi'='nvim'
alias 'vz'='nvim $ZDOTDIR/.zshrc'
alias 'vl'='nvim $ZDOTDIR/.zshrc_local'
alias 'vv'='nvim $HOME/dotfiles/vim/.vimrc'
alias 'less'='less -NM'
alias 'reload'='exec $SHELL -l'
alias 'ju'='jupyter notebook'
alias 'envpath'='echo $PATH | tr ":" "\n"'
## hash ##

#===========#
#   zplug   #
#===========#
# zplug setting
source $ZPLUG_HOME/init.zsh
# define zplug
zplug "mollifier/cd-gitroot"
zplug "b4b4r07/enhancd", use:enhancd.sh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "rupa/z"
zplug "plugins/git", from:oh-my-zsh
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "b4b4r07/zsh-gomi", if:"which fzf"
zplug "arks22/tmuximum", as:command
# install zplug
if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi
# plugin load
zplug load
