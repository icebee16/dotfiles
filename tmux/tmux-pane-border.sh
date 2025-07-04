#!/bin/zsh

if git_status=$(cd "$1" && git status 2>/dev/null); then
  git_branch=$(cd "$1" && git rev-parse --abbrev-ref HEAD)

  case "$git_status" in
    *Changes\ not\ staged* ) state="#[fg=colour013,bg=black,bold] ~ #[fg=default]" ;;
    *Changes\ to\ be\ committed* ) state="#[fg=blue,bg=black,bold] + #[default]" ;;
    * ) state="#[fg=green,bg=black] ✔ #[default]" ;;
  esac

  if [[ "$git_branch" == "master" ]]; then
    git_info="#[bg=black,fg=cyan]⭠ #[default]${state}#[underscore]#[bg=black,fg=cyan]${git_branch}#[default]#[bg=black,fg=cyan] "
  else
    git_info="#[bg=black,fg=colour014]⭠ #[default]${state}#[underscore]#[bg=black,fg=colour014]${git_branch}#[default]#[bg=black,fg=colour014] "
  fi

  array=( $(echo "$1" | tr -s '/' ' ') )
  last_index=${#array[@]}
  current_dir="${array[$last_index]}"

  directory="#[bg=black,fg=cyan, bold] [$current_dir]#[default]$git_info"
else
  directory=""
fi

echo "$directory"
