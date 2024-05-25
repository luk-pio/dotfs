export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    brew 
    npm 
    pip 
    python
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-fzf-history-search
)

source $HOME/.config/zsh/p10k.sh
source $ZSH/oh-my-zsh.sh

source $HOME/.config/zsh/alias.sh
source $HOME/.config/zsh/vi-mode.sh
source $HOME/.config/zsh/env.sh
source $HOME/.config/zsh/fzf.sh
source $HOME/.config/zsh/amzn.sh

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(mise activate zsh)"
