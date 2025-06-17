# ~/.zshrc

#========================#
#  Shell Option & Setup  #
#========================#

# Path
export PATH="$PYENV_ROOT/shims:$PATH"

# zstyle, compinit
autoload -Uz compinit colors bashcompinit
fpath+=$ZDOTDIR/.zfunc
compinit
bashcompinit
colors

# History
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_all_dups hist_ignore_space extended_history inc_append_history
setopt auto_cd auto_pushd pushd_ignore_dups
setopt ignore_eof correct no_beep
setopt auto_param_slash mark_dirs list_types auto_menu globdots

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

#================#
#     Prompt     #
#================#
if [[ -n "$SSH_CONNECTION" ]]; then
  PROMPT="%{${fg[cyan]}%}[%n]%{${reset_color}%}@%{${fg[red]}%}[%m]%{${reset_color}%} %# "
else
  PROMPT="%{${fg[cyan]}%}[%n]%{${reset_color}%}@%{${fg[green]}%}[%m]%{${reset_color}%} %# "
fi
RPROMPT="%{${fg[white]}%}[%~]%{${reset_color}%}"

#================#
#     Aliases    #
#================#
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='nvim'
alias vz='nvim $ZDOTDIR/.zshrc'
alias vl='nvim $ZDOTDIR/.zshrc_local'
alias vv='nvim $HOME/dotfiles/vim/.vimrc'
alias less='less -NM'
alias reload='exec $SHELL -l'
alias ju='jupyter notebook'
alias envpath='echo $PATH | tr ":" "\n"'

#================#
#   Functions    #
#================#
source $ZDOTDIR/.zshrc_util

#================#
#    Plugins     #
#================#
eval "$(sheldon source)"

# FZF Settings
export FZF_DEFAULT_OPTS='--color=fg+:11 --height 70% --reverse --select-1 --exit-0 --multi'
export FZF_DEFAULT_COMMAND='fd --type f --hidden'

#================#
#  Local Config  #
#================#
[[ -f $ZDOTDIR/.zshrc_$(uname) ]] && source $ZDOTDIR/.zshrc_$(uname)
[[ -f $ZDOTDIR/.zshrc_local ]] && source $ZDOTDIR/.zshrc_local
