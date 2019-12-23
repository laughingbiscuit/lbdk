#!/bin/sh

set -e
set -x
set -o pipefail

#  _     ____  ____  _  __
# | |   | __ )|  _ \| |/ /
# | |   |  _ \| | | | ' / 
# | |___| |_) | |_| | . \ 
# |_____|____/|____/|_|\_\
#
# Laughing Biscuit Development Kit

## Description: Idempotent Script to setup my Base Development Environment
## Requirements: Alpine Linux

## Usage: ./lbdk.sh [sudo]
## Repo: https://github.com/laughingbiscuit/lbdk
## Author: LaughingBiscuit

install_lbdk()
{

  # stub sudo if no argument is provided
  if ! echo $@ | grep 'sudo' -q  ; then function sudo { "$@"; }; fi

  # apks
  sudo apk update
  sudo apk upgrade
  sudo apk add man
  sudo apk add \
    curl git jq lastpass-cli less libressl lynx openssh python make nodejs tar \
    npm tmux vim

  # node js
  npm config set unsafe-perm true
  npm config set prefix $HOME/.npm-global
  npm install -g apigeetool eslint http-server js-beautify jwt-cli

  # git
  REPOS="\
  apickli/apickli \
  apigee/openbank \
  apigee/docker-apigee-drupal-kickstart \
  jlevy/the-art-of-command-line \
  mikesson/apigee-mint-cli \
  seymen/accelerator-ci-maven \
  seymen/apickli-ff"

  for REPO in $REPOS; do
    DIR=`echo $REPO | cut -d "/" -f 2`
  done

  # vim
  PLUGINS="sbdchd/neoformat w0rp/ale"
  for REPO in $PLUGINS; do
    DIR=`echo $REPO | cut -d "/" -f 2`
    git clone --depth 1 https://github.com/$REPO \
      ~/.vim/pack/git-plugins/start/$DIR || true
  done

  # copy dotfiles
  SCRIPT=$(readlink -f "$0")
  SCRIPTPATH=$(dirname "$SCRIPT")
  for x in $(ls -a $SCRIPTPATH/dotfiles); do cp $SCRIPTPATH/dotfiles/$x $HOME || true; done

  # gcloud
  curl -sSL \
    https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-274.0.0-linux-x86_64.tar.gz \
    -o $HOME/gcloud.tar.gz
  tar -xvzf $HOME/gcloud.tar.gz -C $HOME
  rm -r $HOME/gcloud.tar.gz
  
  # kubectl
  ARCH=$([ `uname -m` = 'x86_64' ] && 'amd' || 'arm')
  curl -sSL https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/${ARCH}64/kubectl -o /usr/bin/kubectl
  chmod +x /usr/bin/kubectl

  
}

install_lbdk $@
