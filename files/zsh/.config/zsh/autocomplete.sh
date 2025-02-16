#!/bin/zsh
# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U +X bashcompinit && bashcompinit
complete -C aws_completer aws
