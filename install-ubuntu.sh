#!/bin/bash
CWD="$(pwd)"
DOTFS="$(pwd)"

echo
PROMPT="Do you want to set up git and ssh keys? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	read -p "Github email: " EMAIL
	read -p "Github username: " GH_USER
	sudo apt install -y git curl
	# This is used when using 2fa with https to store the access token
	touch ~/.git-credentials
	git config --global credentials.helper store
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
	cd "$CWD"
	git clone https://github.com/luk-pio/dotfs.git
	cd dotfs
	DOTFS="$(pwd)"
	cd "$CWD"
fi

# doom emacs
echo
PROMPT="Do you want to install doom python dependencies? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	pip3 install --user isort pipenv pytest
fi

echo
PROMPT="Do you want to set up doom emacs? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	cd "$HOME"
	sudo apt install -y ripgrep fd-find
	sudo snap install emacs --candidate --classic
	git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
	~/.emacs.d/bin/doom install
	cd "$DOTFS"
	# TODO recursively link all files under .doom and .emacs
	rm "$HOME/.doom.d/config.el" "$HOME/.doom.d/packages.el"
	ln -s -b "$DOTFS/.doom.d/config.el" "$HOME/.doom.d/config.el"
	ln -s -b "$DOTFS/.doom.d/packages.el" "$HOME/.doom.d/packages.el"
	ln -s -b "$DOTFS/.doom.d/init.el" "$HOME/.doom.d/init.el"
	ln -s -b "$DOTFS/.emacs.d/.local/etc/bookmarks" "$HOME/.emacs.d/.local/etc/bookmarks"
	mkdir -p "$HOME/.config/systemd/user/"

	ln -s -b "$DOTFS/emacs.service" "$HOME/.config/systemd/user/emacs.service"
	systemctl --user daemon-reload
	systemctl --user enable emacs
	systemctl --user start emacs

	ln -s -b "$DOTFS/doom.desktop" "$HOME/.local/share/applications/doom.desktop"
	cd "$CWD"
fi

# Font

echo
PROMPT="Hack font? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	curl -O "https://github.com/pyrho/hack-font-ligature-nerd-font/raw/master/font/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf"
fi


## vim

echo
PROMPT="Do you want to set up vim? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	sudo apt install -y vim
	mkdir -p "$HOME/.vim"
	cd "$DOTFS"
	ln -s -b "$DOTFS/.vimrc" "$HOME/.vimrc"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -s -b "$DOTFS/.vim/plugins.vim" "$HOME/.vim/plugins.vim"
	cd "$CWD"
fi

# aliases 
echo
PROMPT="Link aliases? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	cd "$DOTFS"
	ln -s -b "$DOTFS/.config/aliasrc" "$HOME/.config/aliasrc"
	ln -s -b "$DOTFS/.config/shortcutrc" "$HOME/.config/shortcutrc"
	cd "$CWD"
fi 

# Pycharm
echo
PROMPT="Link ideavimrc? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	cd "$DOTFS"
	ln -s -b "$DOTFS/.ideavimrc" "$HOME/.ideavimrc"
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

## i3
echo
PROMPT="Do you want to copy regolith config? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	cd "$CWD"
	ln -s -b "$DOTFS/.config/regolith/i3/config" "$HOME/.config/regolith/i3/config"
	ln -s -b "$DOTFS/.config/regolith/Xresources" "$HOME/.config/regolith/Xresources"
	ln -s -b "$DOTFS/.config/regolith/i3xrocks" "$HOME/.config/regolith/i3xrocks"
fi

echo
PROMPT="Install Docker? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	sudo apt-get remove docker docker-engine docker.io containerd runc
	sudo apt-get update
	sudo apt-get install  apt-transport-https  ca-certificates  curl  gnupg-agent  software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io
	sudo groupadd docker
	sudo usermod -aG docker $USER
fi


echo
PROMPT="Pull the syncthing container? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	docker pull syncthing/syncthing
fi


echo
PROMPT="Install virtualenvwrapper? [y/n] "
read -p "$PROMPT" ANSWER
if [ -z "$ANSWER" ] || [ "$ANSWER" == "y" ]; then
	python3 -m pip install virtualenvwrapper
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
