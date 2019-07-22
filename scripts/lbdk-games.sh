#!/bin/bash

# install nethack
sudo apt-get install -y nethack-console

# install dwarf fortress
sudo apt-get install -y libsdl1.2-dev libsdl-image1.2-dev libsdl-ttf2.0-dev
mkdir -p ~/games
curl -sSL http://www.bay12games.com/dwarves/df_43_03_linux.tar.bz2 | tar -xvj -C ~/games
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout -- ~/games/df_linux/
curl -OsSL https://github.com/DFHack/dfhack/releases/download/0.43.03-r1/dfhack-0.43.03-r1-Linux-gcc-4.8.1.tar.bz2
