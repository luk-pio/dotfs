. $HOME/.config/zsh/p10k.sh

# Load aliases
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

plugins=(
    git
    brew 
    npm 
    pip 
    python
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


. $HOME/.config/zsh/alias.sh
. $HOME/.config/zsh/vi-mode.sh
. $HOME/.config/zsh/env.sh
. $HOME/.config/zsh/fzf.sh
