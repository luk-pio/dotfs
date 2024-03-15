#!/bin/zsh
alias vim=nvim

mcd() {
    mkdir "$@" && cd "${!#}"
}

function nltermx() {
    if [[ -z "$1" ]]; then
        nlterm -h
        exit 1
    fi

    result=$(nlterm "$1")

    echo "$result"
    echo
    echo -n "Execute? (y/n): "
    read -r answer

    if [[ "$answer" == "y" ]]; then
        source <(echo "$result")
    else
        echo "Aborted."
        exit 0
    fi
}

salias() {
    if [ $# -ne 2 ]; then
        echo "Usage: salias alias_name 'command'"
        return 1
    fi

    local alias_name=$1
    local alias_command=$2

    echo "alias $alias_name='$alias_command'" >> ~/.config/zsh/alias.sh
    zsh
}

alias tf='terraform'
