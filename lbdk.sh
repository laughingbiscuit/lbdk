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
    curl git g++ jq lastpass-cli libressl lynx openssh make nodejs npm tmux vim

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
  # Absolute path this script is in, thus /home/user/bin
  SCRIPTPATH=$(dirname "$SCRIPT")
  for x in $(ls -a $SCRIPTPATH/dotfiles); do cp $SCRIPTPATH/dotfiles/$x /root || true; done
  
}

install_lbdk $@
