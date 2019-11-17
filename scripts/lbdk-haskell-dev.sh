#!/bin/sh

set -e
set -x
set -o pipefail

# _   _           _        _ _ 
#| | | | __ _ ___| | _____| | |
#| |_| |/ _` / __| |/ / _ \ | |
#|  _  | (_| \__ \   <  __/ | |
#|_| |_|\__,_|___/_|\_\___|_|_|
#                              
# ____                 _                                  _   
#|  _ \  _____   _____| | ___  _ __  _ __ ___   ___ _ __ | |_ 
#| | | |/ _ \ \ / / _ \ |/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __|
#| |_| |  __/\ V /  __/ | (_) | |_) | | | | | |  __/ | | | |_ 
#|____/ \___| \_/ \___|_|\___/| .__/|_| |_| |_|\___|_| |_|\__|
#                             |_|                             
# Laughing Biscuit Development Kit


## Description: Tools for working with Apigee
## Requirements: Alpine Linux

## Usage: lbdk-apigee-dev.sh [sudo]
## Repo: https://github.com/laughingbiscuit/lbdk
## Author: LaughingBiscuit

install()
{

  SCRIPT=$(readlink -f "$0")
  SCRIPTPATH=$(dirname "$SCRIPT")

  # stub sudo if no argument is provided
  if ! echo $@ | grep 'sudo' -q  ; then function sudo { "$@"; }; fi

  # apks
  sudo apk update
  sudo apk add ghci
}

install $@
