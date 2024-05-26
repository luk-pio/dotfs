#!/bin/zsh
# Editor
export VISUAL=nvim
export EDITOR=nvim

mcd() {
    mkdir -p "$@" && cd "${!#}"
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

aliasadd() {
    if [ $# -ne 2 ]; then
        echo "Usage: aliasadd alias_name 'command'"
        return 1
    fi

    local alias_name=$1
    local alias_command=$2

    echo "alias $alias_name='$alias_command'" >> ~/.config/zsh/alias.sh
    zsh
}

alias tf='terraform'

# File
alias ranger='yatzi'
export FILE=ranger

# Misc aliases
alias lg="lazygit"
alias i="brew install"
alias u="brew uninstall"
alias fzf="fzf --height 40% --reverse"

function mkd() {
	mkdir -p "$@" && cd "$_";
}

function cfg() {
  $EDITOR "$HOME/.config/zsh/$@.sh"
}

alias ops='eval $(op signin my)'

# Docker
alias docker-stop-all='docker stop $(docker ps -q)'

alias vim=nvim
alias v=nvim

alias s='sesh connect $(sesh list | fzf)'

