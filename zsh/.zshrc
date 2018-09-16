# Created by newuser for 5.5.1

### depend OS ###
[ -f $ZDOTDIR/.zshrc_`uname` ] && . $ZDOTDIR/.zshrc_`uname`


### key bind ###
bindkey -e


### autoload ###
autoload -Uz compinit; compinit
autoload -Uz colors; colors


### Option setting ###
# completion
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

# history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt extended_history

# change directry
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# etc
setopt ignore_eof
setopt correct
setopt no_beep


### zstyle ###
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

### prompt ###
if [ -n "$SSH_CONNECTION" ]; then
	PROMPT="%{${fg[cyan]}%}[%n]%{${reset_color}%}@%{${fg[magenta]}%}[%m]%{${reset_color}%} %# "
	RPROMPT="%{${fg[white]}%}[%~]%{${reset_color}%}"
else
	PROMPT="%{${fg[cyan]}%}[%n]%{${reset_color}%}@%{${fg[green]}%}[%m]%{${reset_color}%} %# "
	RPROMPT="%{${fg[white]}%}[%~]%{${reset_color}%}"
fi


### alias and hash ###
# alias
alias 'ls'='ls -G'
alias 'la'='ls -aG'
alias 'll'='ls -lG'
alias 'rm'='rm -i'
alias 'cp'='cp -i'
alias 'mv'='mv -i'
alias 'vi'='vim'
alias 'vz'='vim $ZDOTDIR/.zshrc'
alias 'vv'='vim $HOME/dotfiles/vim/.vimrc'
alias 'cat'='cat -n'
alias 'less'='less -NM'
alias 'reload'='exec $SHELL -l'
alias 'ju'='jupyter notebook'

### zplug ###
# zplug setting
source $ZPLUG_HOME/init.zsh

# define zplug
zplug "mollifier/cd-gitroot"
zplug "b4b4r07/enhancd", use:enhancd.sh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"

# install zplug  
if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi

zplug load --verbose


