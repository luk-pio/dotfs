#!/bin/bash
#git clone https://github.com/luk-pio/dots.git
#cd dots

# Font
sudo apt install fonts-hack-ttf

# Spacemacs
#sudo apt install emacs
#git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
#git --git-dir=$HOME/.emacs.d/.git checkout develop
#ln .spacemacs $HOME/.spacemacs
#mkdir -p $HOME/emacs.d/private/org-roam/
#ln .emacs.d/private/org-roam/packages.el $HOME/.emacs.d/private/org-roam/packages.el
#cp emacs.service $HOME/.config/systemd/user/emacs.service
#systemctl enable --user emacs
#systemctl start --user emacs
#
## vim
#sudo apt install vim
ln .vimrc $HOME/.vimrc
ln .vim/plugins.vim $HOME/.vim/plugins.vim
#
## zsh
sudo apt install zsh
mv $HOME/.zshrc $HOME/.zshrc.old
ln .zshrc $HOME/.zshrc
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# aliases 
ln .config/aliasrc $HOME/.config/aliasrc
ln .config/shortcutrc $HOME/.config/shortcutrc

# Pycharm
ln .ideavimrc $HOME/.ideavimrc
echo "Remeber to unzip pycharm configs"

# Ranger
#sudo apt install ranger
#mv $HOME/.config/ranger $HOME/.config/ranger.old
#cp -r .config/ranger $HOME/.config/ranger

