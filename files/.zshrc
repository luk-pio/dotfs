export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="edvardm"

plugins=(
    git
    brew 
    npm 
    pip 
    python
    zsh-autosuggestions
    zsh-autocomplete
    zsh-syntax-highlighting
    zsh-vim-mode
    zsh-fzf-history-search
)

source $ZSH/oh-my-zsh.sh
source $HOME/.config/zsh/alias.sh
source $HOME/.config/zsh/autocomplete.sh
source $HOME/.config/zsh/env.sh
source $HOME/.config/zsh/fzf.sh

eval "$(zoxide init zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(mise activate zsh)"

