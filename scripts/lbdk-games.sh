#!/bin/bash

# install nethack
sudo apt-get install -y nethack-console

# install dwarf fortress
sudo apt-get install -y libsdl1.2-dev libsdl-image1.2-dev libsdl-ttf2.0-dev
mkdir -p ~/games
curl -sSL http://www.bay12games.com/dwarves/df_44_12_linux.tar.bz2 | tar -xvj -C ~/games
dotconfig checkout -- ~/games/df_linux/
