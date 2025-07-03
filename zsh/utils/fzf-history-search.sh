function fzf-history-search {
    local cache=${1:=100}
    expr "$cache" + 1 > /dev/null
    local res=$(history -r -E 1 | head -n "$cache" | fzf-tmux | sed 's/^[ \t]*//' | cut -f 6- -d' ')
    if [ -n "$res" ]; then
        local cmd=$(echo "$res" | cut -f 1 -d' ')
        local args=$(echo "$res" | cut -f 2- -d' ')
        printf ">> " && tput setaf 2 && printf "$cmd " && tput setaf 7 && print "$args"
        eval "$res"
    else
        return 1
    fi
}
alias 'hs'='fzf-history-search'
