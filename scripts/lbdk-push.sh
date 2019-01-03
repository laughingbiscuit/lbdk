#!/bin/bash
set -e
set -o pipefail

USER=$(lpass show -u Github)
PASS=$(lpass show -p Github)

if echo $@ | grep 'dot' -q ; then
	# use bare repo for dotfiles and always push to master 
	URL=$(git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME remote get-url origin)
	ERR=$(git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push $(echo $URL | sed "s/https:\/\//https:\/\/$USER:$PASS@/") master 2>&1)
else
	# run git push and catch error
	URL=$(git remote get-url origin)
	ERR=$(git push $(echo $URL | sed "s/https:\/\//https:\/\/$USER:$PASS@/") $@ 2>&1)
fi

# obfuscate password
echo $ERR | sed "s/$PASS/<pass>/"
