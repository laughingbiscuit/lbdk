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

  SCRIPT=$(readlink -f "$0")
  CONFPATH=$(dirname "$SCRIPT")/conf

  # stub sudo if no argument is provided
  if ! echo $@ | grep 'sudo' -q  ; then function sudo { "$@"; }; fi

  # apks
  sudo apk update
  sudo apk upgrade
  sudo apk add man
  APKS=`cat $CONFPATH/apks.txt`
  sudo apk add $APKS

  # node js
  npm config set unsafe-perm true
  npm config set prefix $HOME/.npm-global
  NPM_PKGS=`cat $CONFPATH/npm-packages.txt`
  npm install -g $NPM_PKGS

  # git
  REPOS=`cat $CONFPATH/git-repos.txt`
  for REPO in $REPOS; do
    DIR=`echo $REPO | cut -d "/" -f 2`
  done

  # vim
  PLUGINS=`cat $CONFPATH/vim-plugins.txt`
  for REPO in $PLUGINS; do
    DIR=`echo $REPO | cut -d "/" -f 2`
    git clone --depth 1 https://github.com/$REPO \
      ~/.vim/pack/git-plugins/start/$DIR || true
  done
  
}

install_lbdk $@
