export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="edvardm"


plugins=(
    git
    brew 
    npm 
    pip 
    python
    zsh-syntax-highlighting
    vi-mode
    zsh-autocomplete
)

export ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
export ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1

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

