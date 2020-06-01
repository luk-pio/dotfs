#!/bin/bash
email="l.piotrak@samsung.com"
cwd="$(pwd)"

sudo apt install -y git
git config --global user.name "luk-pio"
git config --global user.email $email
ssh-keygen -t rsa -b 4096 -C $email
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

cd $HOME

# Spacemacs
sudo apt install -y emacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
git --git-dir=$HOME/.emacs.d/.git checkout develop

cd $cwd
git clone https://github.com/luk-pio/dotfs.git
cd dotfs

# Font
sudo apt install -y fonts-hack-ttf

ln  .spacemacs $HOME/.spacemacs
mkdir -p $HOME/.emacs.d/private/org-roam/
ln  .emacs.d/private/org-roam/packages.el $HOME/.emacs.d/private/org-roam/packages.el
mkdir -p $HOME/.config/systemd/user/
cp emacs.service $HOME/.config/systemd/user/emacs.service
systemctl enable --user emacs
systemctl start --user emacs
#
## vim
sudo apt install -y vim
mkdir -p $HOME/.vim
ln  .vimrc $HOME/.vimrc
ln  .vim/plugins.vim $HOME/.vim/plugins.vim

# aliases 
ln  .config/aliasrc $HOME/.config/aliasrc
ln  .config/shortcutrc $HOME/.config/shortcutrc

# Pycharm
ln  .ideavimrc $HOME/.ideavimrc

# Ranger
sudo apt install -y ranger
#mv $HOME/.config/ranger $HOME/.config/ranger.old
#cp -r .config/ranger $HOME/.config/ranger

## zsh
sudo apt install -y zsh
mv $HOME/.zshrc $HOME/.zshrc.old
ln  .zshrc $HOME/.zshrc
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
