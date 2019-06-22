#!/bin/bash

#
# Some simple smoke tests - for each command I need a 0 exit code
#

set -o xtrace
set -e
set -o pipefail 

. ~/.bashrc

# check tools are installed
node -v
curl -V
jq -V
git --version
gpg --version
tmux -V
task --version
ranger --version
openssl version
vim --version
js-beautify --version
eslint --version
godaddy-dns --version
lpass -v
which http-server
php-cs-fixer -V
mutt -v 
which gcalcli
pip -V
which urlscan
gcloud -v
which kubectl
go version
terraform version
ruby -v
gem -v
travis -v

# check that directories exist
ls $HOME/projects/apickli
ls $HOME/projects/accelerator-ci-maven
ls $HOME/.vim/pack/git-plugins/start/ale
ls $HOME/.vim/pack/git-plugins/start/neoformat
ls $HOME/.dotfiles

