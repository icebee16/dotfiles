function fzf-file() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0 --preview 'head -n 100 {}'))
  [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}
alias 'fe'='fzf-file'
