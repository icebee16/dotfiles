function fzf-cd-directory {
    local res=$(z | sort -rn | cut -c 12- | fzf-tmux --preview 'tree -C {} | head -200')
    if [ -n "$res" ]; then
        cd $res
    else
        return 1
    fi
}
alias 'cdd'='fzf-cd-directory'
