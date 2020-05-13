#!/bin/bash
email="l.piotrak@samsung.com"

sudo apt install -y git curl
git config --global user.name "luk-pio"
git config --global user.email $email
ssh-keygen -t rsa -b 4096 -C $email
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

git clone https://github.com/luk-pio/dotfs.git
cd dotfs

# Font
sudo apt install -y fonts-hack-ttf

# Spacemacs
sudo apt install -y emacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
git --git-dir=$HOME/.emacs.d/.git checkout develop
ln -s .spacemacs $HOME/.spacemacs
mkdir -p $HOME/emacs.d/private/org-roam/
ln -s ./.emacs.d/private/org-roam/packages.el $HOME/.emacs.d/private/org-roam/packages.el
mkdir -p $HOME/.config/systemd/user/
cp emacs.service $HOME/.config/systemd/user/emacs.service
systemctl enable --user emacs
systemctl start --user emacs
#
## vim
sudo apt install -y vim
ln -s .vimrc $HOME/.vimrc
ln -s .vim/plugins.vim $HOME/.vim/plugins.vim
#
## zsh
sudo apt install -y zsh
mv $HOME/.zshrc $HOME/.zshrc.old
ln -s .zshrc $HOME/.zshrc
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# aliases 
ln -s .config/aliasrc $HOME/.config/aliasrc
ln -s .config/shortcutrc $HOME/.config/shortcutrc

# Pycharm
ln -s .ideavimrc $HOME/.ideavimrc
echo "Remeber to unzip pycharm configs"

# Ranger
sudo apt install -y ranger
#mv $HOME/.config/ranger $HOME/.config/ranger.old
#cp -r .config/ranger $HOME/.config/ranger

