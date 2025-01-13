#!/usr/bin/env bash

# Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew="/home/linuxbrew/.linuxbrew/bin/brew"
if [[ $(uname -s) == "Darwin" ]]; then
        brew="/opt/homebrew/bin/brew"
fi
$brew bundle

# Stow
(
cd files
stow -v --adopt -t $HOME git
stow -v --adopt -t $HOME ideavim
stow -v --adopt -t $HOME iterm
stow -v --adopt -t $HOME ssh
stow -v --adopt -t $HOME tmux
stow -v --adopt -t $HOME zsh
stow -v --adopt -t $HOME nvim
stow -v --adopt -t $HOME ghostty
)

# OMZ
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH='no' KEEP_ZSH='yes' sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/marlonrichert/zsh-autocomplete.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
  git clone https://github.com/joshskidmore/zsh-fzf-history-search \
    ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
else
  echo "~/.oh-my-zsh already exists. Skipping installation."
fi
# curl "https://raw.githubusercontent.com/pyrho/hack-font-ligature-nerd-font/master/font/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf" Hack_Regular_Nerd_Font_Mono.ttf

