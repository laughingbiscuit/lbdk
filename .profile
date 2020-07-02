#!/bin/sh
export PS1="$ "
git config --global user.name "LaughingBiscuit"
git config --global user.email "`lpass show -u Github`"
