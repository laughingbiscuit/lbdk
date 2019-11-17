#!/bin/sh

set -e
set -x
set -o pipefail

#            _                 _ 
#  __ _  ___| | ___  _   _  __| |
# / _` |/ __| |/ _ \| | | |/ _` |
#| (_| | (__| | (_) | |_| | (_| |
# \__, |\___|_|\___/ \__,_|\__,_|
# |___/                          
#     _                _                                  _   
#  __| | _____   _____| | ___  _ __  _ __ ___   ___ _ __ | |_ 
# / _` |/ _ \ \ / / _ \ |/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __|
#| (_| |  __/\ V /  __/ | (_) | |_) | | | | | |  __/ | | | |_ 
# \__,_|\___| \_/ \___|_|\___/| .__/|_| |_| |_|\___|_| |_|\__|
#                             |_|                             
# Laughing Biscuit Development Kit


## Description: Tools for working with Google Cloud
## Requirements: Alpine Linux

## Usage: lbdk-gcloud-dev.sh [sudo]
## Repo: https://github.com/laughingbiscuit/lbdk
## Author: LaughingBiscuit

install()
{

  SCRIPT=$(readlink -f "$0")
  SCRIPTPATH=$(dirname "$SCRIPT")

  # stub sudo if no argument is provided
  if ! echo $@ | grep 'sudo' -q  ; then function sudo { "$@"; }; fi

  #curl
  curl -o /tmp/gcloud.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-271.0.0-linux-x86_64.tar.gz

  # tar
  tar -xvzf /tmp/gcloud.tar.gz -C /root
}

install $@
