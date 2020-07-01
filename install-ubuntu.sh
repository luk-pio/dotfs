#!/bin/bash
CWD="$(pwd)"
DOTFS="$(pwd)"

echo
PROMPT="Do you want to set up git and ssh keys? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	read -p "Input your github email: " EMAIL
	read -p "Input your github username: " GH_USER
	sudo apt install -y git curl
	git config --global user.name "$GH_USER"
	git config --global user.email $EMAIL
	ssh-keygen -t rsa -b 4096 -C $EMAIL
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa
fi


echo
PROMPT="Do you want to clone the dotfs repo? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	cd $CWD
	git clone https://github.com/luk-pio/dotfs.git
	cd dotfs
	DOTFS="$(cwd)"
	cd $CWD
fi

# Spacemacs

echo
PROMPT="Do you want to set up spacemacs? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	cd $HOME
	sudo apt install -y emacs
	git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
	cd ~/.emacs.d
	git checkout develop
	cd "$DOTFS"
	ln .spacemacs $HOME/.spacemacs
	mkdir -p $HOME/.emacs.d/private/org-roam/
	ln  .emacs.d/private/org-roam/packages.el $HOME/.emacs.d/private/org-roam/packages.el
	mkdir -p $HOME/.emacs.d/private/snippets/org-mode
	ln  .emacs.d/private/snippets/org-mode/work-cycle $HOME/.emacs.d/private/snippets/org-mode/work-cycle
	mkdir -p $HOME/.config/systemd/user/
	cp emacs.service $HOME/.config/systemd/user/emacs.service
	systemctl enable --user emacs
	systemctl start --user emacs
	cd "$CWD"
fi

# Font

echo
PROMPT="Hack font? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	sudo apt install -y fonts-hack-ttf
fi


## vim

echo
PROMPT="Do you want to set up vim? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	sudo apt install -y vim
	mkdir -p $HOME/.vim
	cd "$DOTFS"
	ln  .vimrc $HOME/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln  .vim/plugins.vim $HOME/.vim/plugins.vim
	cd "$CWD"
fi

# aliases 
echo
PROMPT="Link aliases? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	cd "$DOTFS"
	ln  .config/aliasrc $HOME/.config/aliasrc
	ln  .config/shortcutrc $HOME/.config/shortcutrc
	cd "$CWD"
fi 

# Pycharm
echo
PROMPT="Link ideavimrc? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	cd "$DOTFS"
	ln  .ideavimrc $HOME/.ideavimrc
	cd "$CWD"
fi

# Ranger
echo
PROMPT="Do you want to set up ranger? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	cd "$DOTFS"
	sudo apt install -y ranger
	cd "$CWD"
	#mv $HOME/.config/ranger $HOME/.config/ranger.old
	#cp -r .config/ranger $HOME/.config/ranger
fi

## zsh
echo
PROMPT="Do you want to set up zsh? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	cd "$DOTFS"
	sudo apt install -y zsh
	cd "$CWD"
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
