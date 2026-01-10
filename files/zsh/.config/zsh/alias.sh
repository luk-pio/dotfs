#!/bin/zsh
# Editor
export VISUAL=nvim
export EDITOR=nvim

# File
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

export FILE=yazi

# Misc aliases
alias fzf="fzf --height 40% --reverse"

function mkd() {
	mkdir -p "$@" && cd "$_";
}

function cfg() {
  $EDITOR "$HOME/.config/zsh/$@.sh"
}

alias ops='eval $(op signin my)'

alias vim="nvim"
alias v="nvim"

alias s='sesh connect $(sesh list | fzf)'
alias cat=bat

# Claude Code in new git worktree
alias ccwt='f() { git worktree add "../$1" "${2:-$1}" && cd "../$1" && claude; }; f'
