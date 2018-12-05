#!/bin/bash

# Laughing Biscuit Development Kit
#
#	Description: A scrappy idempotent script to setup my Development Environment
#	Requirements: Termux or Debian Stretch
#	Usage: ./lbdk.sh [-s]
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

# install some basic tools
sudo apt-get update
sudo apt-get install -y curl jq git cmake

# install nodejs lts
curl -sSL https://deb.nodesource.com/setup_10.x | bash || sudo apt-get install -y nodejs-lts 

# install apt packages
for APT_PKG in $(jq -r '.apt | join(" ")' $LBDK_CONF) ; do
	sudo apt-get install -y $APT_PKG || true
done

# install npm packages
mkdir -p $HOME/.npm-global
npm config set prefix $HOME/.npm-global
for NPM_PKG in $(jq -r '.npm | join(" ")' $LBDK_CONF) ; do
	sudo apt-get install -y $APT_PKG || true
done

# pull git repos
mkdir -p $HOME/projects
for GIT_REPO in $(jq -r '.git | join(" ")' $LBDK_CONF) ; do
	cd $HOME/projects && git clone --depth 1 https://github.com/$GIT_REPO || true
done

# setup nvim plugins
PLUGIN_DIR=$HOME/.local/share/nvim/site/pack/git-plugins/start
mkdir -p $PLUGIN_DIR
for VIM_PLUGIN in $(jq -r '.vim | join(" ")' $LBDK_CONF) ; do
	cd $PLUGIN_DIR && git clone --depth 1 https://github.com/$VIM_PLUGIN || true
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
	sudo apt-get install -y xinit i3 arandr firefox-esr xfce4-terminal 
fi
