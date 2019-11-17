#!/bin/sh

set -e
set -x
set -o pipefail

# ____            _    _              
#|  _ \  ___  ___| | _| |_ ___  _ __  
#| | | |/ _ \/ __| |/ / __/ _ \| '_ \ 
#| |_| |  __/\__ \   <| || (_) | |_) |
#|____/ \___||___/_|\_\\__\___/| .__/ 
#                              |_|    
# _____            _                                      _   
#| ____|_ ____   _(_)_ __ ___  _ __  _ __ ___   ___ _ __ | |_ 
#|  _| | '_ \ \ / / | '__/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __|
#| |___| | | \ V /| | | | (_) | | | | | | | | |  __/ | | | |_ 
#|_____|_| |_|\_/ |_|_|  \___/|_| |_|_| |_| |_|\___|_| |_|\__|
# Laughing Biscuit Development Kit

## Description: Alpine on the Desktop
## Requirements: Alpine Linux

## Usage: lbdk-install-desktop.sh [sudo]
## Repo: https://github.com/laughingbiscuit/lbdk
## Author: LaughingBiscuit

install()
{

  SCRIPT=$(readlink -f "$0")
  SCRIPTPATH=$(dirname "$SCRIPT")

  # stub sudo if no argument is provided
  if ! echo $@ | grep 'sudo' -q  ; then function sudo { "$@"; }; fi

  # dwm, st, dmenu
  # firefox
  # firefox plugins
  # network manager
  # alsa
  # xrandr, feh

}

install $@
