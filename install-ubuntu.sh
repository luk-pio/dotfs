#!/bin/bash
email="l.piotrak@samsung.com"

sudo apt install -y git curl
git config git config --global user.name "luk-pio"
git config --global user.email $email
ssh-keygen -t rsa -b 4096 -C $email
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# Dropbox
curl -O "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd
sudo apt install python
sudo wget -O /usr/local/bin/dropbox "https://www.dropbox.com/download?dl=packages/dropbox.py"
sudo chmod +x /usr/local/bin/dropbox
sudo systemctl daemon-reload
sudo systemctl enable dropbox
sudo systemctl start dropbox

git clone https://github.com/luk-pio/dotfs.git
cd dotfs

# Font
sudo apt install -y fonts-hack-ttf

# Spacemacs
sudo apt install -y emacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
git --git-dir=$HOME/.emacs.d/.git checkout develop
ln .spacemacs $HOME/.spacemacs
mkdir -p $HOME/emacs.d/private/org-roam/
ln .emacs.d/private/org-roam/packages.el $HOME/.emacs.d/private/org-roam/packages.el
cp emacs.service $HOME/.config/systemd/user/emacs.service
systemctl enable --user emacs
systemctl start --user emacs
#
## vim
#sudo apt install -y vim
ln .vimrc $HOME/.vimrc
ln .vim/plugins.vim $HOME/.vim/plugins.vim
#
## zsh
sudo apt install -y zsh
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
#sudo apt install -y ranger
#mv $HOME/.config/ranger $HOME/.config/ranger.old
#cp -r .config/ranger $HOME/.config/ranger

