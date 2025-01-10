#!/bin/zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias fzf="fzf --height 40% --reverse"
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
