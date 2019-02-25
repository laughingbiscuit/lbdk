#!/bin/bash

# include some useful stuff
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $SCRIPT_DIR/lbdk-prefix.sh 

# install nethack
sudo apt-get install -y nethack-console

# install dwarf fortress
sudo apt-get install -y libsdl1.2-dev libsdl-image1.2-dev libsdl-ttf2.0-dev
DF_DIR=$SCRIPT_DIR/../target/df
mkdir -p $DF_DIR
curl -sSL http://www.bay12games.com/dwarves/df_44_12_linux.tar.bz2 -o $DF_DIR/df.tar.bz2
tar -xvf $DF_DIR/df.tar.bz2 -C $DF_DIR
sed -i 's/\[SOUND:.*\]/\[SOUND:NO\]/g' $DF_DIR/df_linux/data/init/init.txt
sed -i 's/\[INTRO:.*\]/\[INTRO:NO\]/g' $DF_DIR/df_linux/data/init/init.txt
sed -i 's/\[PRINT_MODE:.*\]/\[PRINT_MODE:TEXT\]/g' $DF_DIR/df_linux/data/init/init.txt

# install runescape
sudo apt-get install -y dirmngr
echo "deb http://ppa.launchpad.net/hikariknight/unix-runescape-client/ubuntu zesty main" | sudo tee -a /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9BA73CFA
sudo apt-get update && sudo apt-get install -y unix-runescape-client

