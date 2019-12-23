#!/bin/sh

set -e 

# check apk packages installed
curl --version
git --version
jq --version
lpass --version
less --version
libressl --version
which lynx
which ssh
python  --version
make --version
node --version
tar --version
npm  --version
tmux -V
vim --version

# npm
which apigeetool
which eslint
which http-server
which js-beautify
which jwt-cli

# gcloud bins
gcloud --version
kubectl --version
