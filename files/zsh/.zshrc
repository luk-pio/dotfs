export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="edvardm"

plugins=(
    git
    brew 
    npm 
    pip 
    python
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-autocomplete
    zsh-vi-mode
    zsh-fzf-history-search
)

source $ZSH/oh-my-zsh.sh
source $HOME/.config/zsh/alias.sh
source $HOME/.config/zsh/autocomplete.sh
source $HOME/.config/zsh/env.sh
source $HOME/.config/zsh/fzf.sh
source $HOME/.config/zsh/amzn/amzn.sh

if [ -d "/opt/homebrew/bin/brew" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -d "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"

