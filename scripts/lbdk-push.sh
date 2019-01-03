#!/bin/bash
set -e
set -o pipefail

URL=$(git remote get-url origin)
USER=$(lpass show -u Github)
PASS=$(lpass show -p Github)

# run git push and catch error
ERR=$(git push $(echo $URL | sed "s/https:\/\//https:\/\/$USER:$PASS@/") $@ 2>&1)
# obfuscate password
echo $ERR | sed "s/$PASS/<pass>/"
