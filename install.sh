#!/usr/bin/env bash

CWD="$(pwd)"
DOTFS="$(pwd)"
INSTALL_CMD="brew install"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else 
  echo "~/.oh-my-zsh already exists. Skipping installation."
fi

# curl "https://raw.githubusercontent.com/pyrho/hack-font-ligature-nerd-font/master/font/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf" Hack_Regular_Nerd_Font_Mono.ttf

