#!/bin/bash

# Laughing Biscuit Development Kit
#
#	Description: A scrappy idempotent script to setup my Development Environment
#	Requirements: Termux or Debian Stretch
#	Usage: ./lbdk.sh [--sudo] [--ui]
#	Repo: https://github.com/laughingbiscuit/development-kit.git
#	Author: LaughingBiscuit

set -o xtrace
set -e
set -o pipefail 

LBDK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LBDK_CONF="$LBDK_DIR/config.json"
ARGS="$@"

# stub sudo if no argument is provided
if ! echo $ARGS | grep 'sudo' -q  ; then
	function sudo {
		"$@"
	}
fi

# create required dirs
mkdir -p $LBDK_DIR/target

# install some basic tools
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y curl jq git cmake gnupg
sudo apt-get install -y python-pip || true

# install nodejs lts
(curl -sSL https://deb.nodesource.com/setup_10.x | sudo bash && sudo apt-get install -y nodejs) || sudo apt-get install -y nodejs-lts 

# install apt packages
for APT_PKG in $(jq -r '.apt | join(" ")' $LBDK_CONF) ; do
	sudo apt-get install -y $APT_PKG || true
done

# install npm packages
mkdir -p $HOME/.npm-global
npm config set prefix $HOME/.npm-global
for NPM_PKG in $(jq -r '.npm | join(" ")' $LBDK_CONF) ; do
	sudo npm install -g $NPM_PKG || true
done

# pull git repos
mkdir -p $HOME/projects
for GIT_REPO in $(jq -r '.git | join(" ")' $LBDK_CONF) ; do
	cd $HOME/projects && git clone --depth 1 https://github.com/$GIT_REPO || true
done

# setup vim plugins
PLUGIN_DIR=$HOME/.vim/pack/git-plugins/start
mkdir -p $PLUGIN_DIR
for VIM_PLUGIN in $(jq -r '.vim | join(" ")' $LBDK_CONF) ; do
	cd $PLUGIN_DIR && git clone --depth 1 https://github.com/$VIM_PLUGIN || true
done

# setup pip modules
for PIP_PKG in $(jq -r '.pip | join(" ")' $LBDK_CONF) ; do
	sudo pip install $PIP_PKG || true
done

# setup dotfiles
if [ ! -d ~/.dotfiles ]; then
	# move previous bashrc
	[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.old

	# Clone our dotfiles
	git clone --bare https://github.com/laughingbiscuit/dotfiles.git ~/.dotfiles
	git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
else
	git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull || true
fi

# build tools from source
## lastpass
(cd $HOME/projects/lastpass-cli && make && sudo make install) || true

# add x and some simple tools
if echo $ARGS | grep 'ui' -q  ; then
	sudo apt-get install -y xinit i3 arandr firefox-esr xfce4-terminal feh compton wicd wicd-curses
fi

# install php formatter (package managers are lacking...)
curl https://cs.symfony.com/download/php-cs-fixer-v2.phar -o $LBDK_DIR/target/php-cs-fixer
chmod +x $LBDK_DIR/target/php-cs-fixer

# set up locales
sudo sed -i 's/# en_GB.UTF-8/en_GB.UTF-8/g' /etc/locale.gen || sudo echo 'en_GB.UTF-8 UTF-8' > /etc/locale.gen && sudo apt-get install -y locales && locale-gen || true
