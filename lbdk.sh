#!/bin/bash

# Laughing Biscuit Development Kit
#
#	Description: A scrappy idempotent script to setup my Development Environment
#	Requirements: Debian Stretch
LSB_RELEASE="stretch"
#	Usage: ./lbdk.sh [sudo] [ui] 
#	Repo: https://github.com/laughingbiscuit/lbdk.git
#	Author: LaughingBiscuit
set -o xtrace
set -e
set -o pipefail 

# stub sudo if no argument is provided
if ! echo $@ | grep 'sudo' -q  ; then
	function sudo {
		"$@"
	}
fi

#####
# mkdirs
#####

mkdir -p ~/.vim/swapfiles
mkdir -p ~/.npm-global
mkdir -p ~/projects
mkdir -p ~/.vim/pack/git-plugins/start
mkdir -p ~/.local/share

#####
# prereqs
#####

sudo apt-get update && sudo apt-get install -y curl gnupg apt-transport-https

#####
# apts
#####

echo "deb https://deb.nodesource.com/node_12.x $LSB_RELEASE main"|\
  sudo tee /etc/apt/sources.list.d/nodesource.list
echo "deb http://packages.cloud.google.com/apt cloud-sdk-$LSB_RELEASE main" |\
  sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

curl -sSL "https://deb.nodesource.com/gpgkey/nodesource.gpg.key" |\
  sudo apt-key add -
curl -sSL "https://packages.cloud.google.com/apt/doc/apt-key.gpg" |\
  sudo apt-key add -

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y \
  apache2-utils \
  bash-completion \
  build-essential \
  ca-certificates \
  calcurse \
  cmake  \
  ctags \
  git  \
  google-cloud-sdk \
  htop \
  jq  \
  kubectl \
  libcurl3 \
  libcurl4-openssl-dev \
  libssl1.0 \
  libssl1.0-dev \
  libxml2 \
  libxml2-dev \
  lynx \
  man \
  maven \
  mutt \
  nodejs \
  openjdk-8-jdk-headless \
  php \
  pkg-config \
  plantuml \
  python-pip \
  ranger \
  ruby-full \
  taskwarrior \
  tmux \
  unzip \
  urlscan \
  vim 

#####
# npm
#####

npm config set prefix $HOME/.npm-global
sudo npm install -g \
  apigeetool \
  eslint \
  godaddy-dns \
  http-server \
  js-beautify \
  nodemon \
  npm \
  tldr

#####
# git
#####

REPOS=$(cat <<-END
  seymen/accelerator-ci-maven
  seymen/apickli-ff
  apickli/apickli
  lastpass/lastpass-cli
  laughingbiscuit/apigee-reference-bank
  jlevy/the-art-of-command-line
END
)
for REPO in $REPOS; do
  DIR=$(echo $REPO | cut -d "/" -f 2)
	git clone --depth 1 https://github.com/$REPO ~/projects/$DIR || true
done

#####
# vim plugins
#####

PLUGINS=$(cat <<-END
  sbdchd/neoformat
  w0rp/ale
  gyim/vim-boxdraw

END
)

for REPO in $PLUGINS; do
  DIR=$(echo $REPO | cut -d "/" -f 2)
	git clone --depth 1 https://github.com/$REPO \
    ~/.vim/pack/git-plugins/start/$DIR || true
done

#####
# pip plugins
#####

sudo pip install \
  gcalcli \
  linode-cli

#####
# dotfiles
#####

if [ ! -d ~/.dotfiles ]; then
	[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.old
	git clone --bare https://github.com/laughingbiscuit/dotfiles.git ~/.dotfiles
	git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
else
	git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull || true
fi

#####
# build source
#####

git -C ~/projects/lastpass-cli pull
make -C ~/projects/lastpass-cli
sudo make install -C ~/projects/lastpass-cli

#####
# UI Tools
#####
 
if echo $@ | grep 'ui' -q  ; then
	sudo apt-get install -y \
    alsa-utils \
    arandr \
    compton \
    feh \
    chromium \
    i3 \
    xclip \
    xfce4-terminal \
    xinit
#   kdenlive - only needed for video editing

  if uname -m | grep 'arm' -q  ; then
    sudo apt-get install -y chromium-browser
  else
    sudo apt-get install -y chromium
  fi
fi

#####
# PHP
#####

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

composer global require \
  friendsofphp/php-cs-fixer

#####
# Ruby Gems
#####

sudo gem install travis
echo "y" | travis

#####
# Binaries
#####

if uname -m | grep 'arm' -q  ; then
  curl https://dl.google.com/go/go1.12.6.linux-armv6l.tar.gz -o /tmp/go.tar.gz
else
  curl https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz -o /tmp/go.tar.gz
fi
sudo tar --overwrite -C /usr/local -xzf /tmp/go.tar.gz

if uname -m | grep 'arm' -q  ; then
  curl -o /tmp/terraform.zip \
    https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_arm.zip
else
  curl -o /tmp/terraform.zip \
    https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
fi
sudo unzip -d /usr/local/bin /tmp/terraform.zip

#####
# Locale
#####

sudo sed -i 's/# en_GB.UTF-8/en_GB.UTF-8/g' /etc/locale.gen ||\ 
  sudo echo 'en_GB.UTF-8 UTF-8' > /etc/locale.gen &&\
  sudo apt-get install -y locales && sudo locale-gen || true

