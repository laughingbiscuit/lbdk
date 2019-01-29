#!/bin/bash

#
# Some simple smoke tests
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
php-cs-fixer -V

# check that directories exist
ls $HOME/projects/apickli
ls $HOME/projects/accelerator-ci-maven
ls $HOME/.local/share/nvim/site/pack/git-plugins/start/ale
ls $HOME/.local/share/nvim/site/pack/git-plugins/start/neoformat
ls $HOME/.dotfiles
