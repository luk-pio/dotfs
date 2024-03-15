# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
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
. $HOME/.config/focusrite-requests.zsh

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
