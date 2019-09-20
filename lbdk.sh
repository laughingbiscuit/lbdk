#!/bin/bash

# Laughing Biscuit Development Kit
#
#	Description: A scrappy idempotent script to setup my Development Environment
#	Requirements: Alpine Linux

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
# apks
#####

sudo echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
sudo apk update
sudo apk upgrade
sudo apk add \
  apache2-utils \
  bash-completion \
  build-base \
  ca-certificates \
  calcurse \
  cmake  \
  composer \
  ctags \
  curl \
  docker \
  figlet \
  git  \
  go \
  htop \
  jq  \
  lastpass-cli \
  libressl \
  lynx \
  man \
  maven \
  mutt \
  nodejs \
  npm \
  openjdk11-jdk \
  py2-pip \
  ranger \
  task \
  terraform \
  tmux \
  unzip \
  urlscan \
  vim \
  yarn
#  php7 \
#  php7-tokenizer \
#  ruby-dev \
#  ruby-rdoc \

#####
# yarn
#####

yarn config set prefix $HOME/.npm-global
sudo yarn global add \
  apigeetool \
  eslint \
  http-server \
  js-beautify \
  nodemon \
  jwt-cli \
  tldr

#####
# git
#####

REPOS=$(cat <<-END
  seymen/accelerator-ci-maven
  seymen/apickli-ff
  apickli/apickli
  lastpass/lastpass-cli
  apigee/openbank
  apigee/docker-apigee-drupal-kickstart
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
# build source
#####
curl -sSL https://sdk.cloud.google.com | bash

#####
# dotfiles
#####

if [ ! -d ~/.dotfiles ]; then
	[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.old
	git clone --bare https://github.com/laughingbiscuit/dotfiles.git ~/.dotfiles
	git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout --force
else
	git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull || true
fi

#####
# UI Tools
#####

#####
# Binaries
#####

if uname -m | grep 'arm' -q  ; then
  curl https://get.helm.sh/helm-v2.14.2-linux-arm.tar.gz -o /tmp/helm.tar.gz
  tar --overwrite -C /tmp -xzf /tmp/helm.tar.gz
  sudo mv /tmp/linux-arm/helm /usr/local/bin
else
  curl https://get.helm.sh/helm-v2.14.2-linux-amd64.tar.gz -o /tmp/helm.tar.gz
  tar --overwrite -C /tmp -xzf /tmp/helm.tar.gz
  sudo mv /tmp/linux-amd64/helm /usr/local/bin
fi

go get github.com/googlecodelabs/tools/claat
curl -sSL https://downloads.sourceforge.net/project/plantuml/1.2019.10/plantuml-jar-mit-1.2019.10.zip -o /tmp/plantuml.zip
unzip -o -d /tmp/plantuml /tmp/plantuml.zip
mv /tmp/plantuml/plantuml.jar $HOME/plantuml.jar
