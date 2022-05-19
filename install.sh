#!/usr/bin/env bash

# ---------------------------
# -      Definitions        -
# ---------------------------

CWD="$(pwd)"
DOTFS="$(pwd)"
INSTALL_CMD="brew install"

# $1: File path from ~
symlink_confirm_overwrite() {
  echo
  PROMPT="Link $1? [y/n] "
  read -p "$PROMPT" ANSWER
  if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
    if [ -f "$HOME/$1" ]; then
      PROMPT="~/$1 already exists. Overwrite? [y/n]"
      read -p "$PROMPT" ANSWER
      if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
        ln -s -f "$DOTFS/files/$1" "$HOME/$1"
      fi
    fi
  fi 
}

# $1: Prompt message, $2: Command to execute
do_if_confirmation() {
  echo
  PROMPT="$1 [y/n] "
  read -p "$PROMPT" ANSWER
  if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
    eval $2
  fi 
}

# ---------------------------
# -         Shell           -
# ---------------------------

# zsh
symlink_confirm_overwrite .zshrc
do_if_confirmation "Do you want to set up oh-my-zsh?" '
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
'
symlink_confirm_overwrite .p10k.zsh

# ---------------------------
# -      Shell Utils        -
# ---------------------------

# ssh
mkdir $HOME/.ssh
symlink_confirm_overwrite .ssh/config

# git
symlink_confirm_overwrite .gitconfig

# tmux
symlink_confirm_overwrite .tmux.conf

# aliases
symlink_confirm_overwrite .aliasrc

# ranger
do_if_confirmation "Do you want to set up ranger?" '$INSTALL ranger'

# ---------------------------
# -         Editors         -
# ---------------------------

symlink_confirm_overwrite .vimrc

do_if_confirmation "Do you want to set up vim Plugins?" '
	mkdir -p "$HOME/.vim"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -s "$DOTFS/.vim/plugins.vim" "$HOME/.vim/plugins.vim"
	cd "$CWD"
'
symlink_confirm_overwrite .ideavimrc


do_if_confirmation "Do you want to Download Hack font?" 'curl "https://raw.githubusercontent.com/pyrho/hack-font-ligature-nerd-font/master/font/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf" Hack_Regular_Nerd_Font_Mono.ttf'

