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
    # zsh-autocomplete
    zsh-autosuggestions
)

export ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
export ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1

source $ZSH/oh-my-zsh.sh
source $HOME/.config/zsh/alias.sh
source $HOME/.config/zsh/autocomplete.sh
source $HOME/.config/zsh/env.sh
source $HOME/.config/zsh/amzn/env.sh
source $HOME/.config/zsh/fzf.sh


if [ -d "/opt/homebrew/bin/brew" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -d "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

eval "$(zoxide init zsh)"


export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/Users/l/.bun/_bun" ] && source "/Users/l/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
alias godot="/Applications/Godot.app/Contents/MacOS/Godot"
