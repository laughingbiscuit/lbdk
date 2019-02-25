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
sudo apt-get install -y osbuddy jarwrapper

TARGET_DIR=$SCRIPT_DIR/../target
mkdir -p $TARGET_DIR

# install wine
sudo dpkg --add-architecture i386
curl -sSL https://dl.winehq.org/wine-builds/winehq.key -o $TARGET_DIR/winehq.key
sudo apt-key add $TARGET_DIR/winehq.key
sudo echo '# Wine repo' >> /etc/apt/sources.list
sudo echo 'deb https://dl.winehq.org/wine-builds/debian/ stretch main ' >> /etc/apt/sources.list
sudo apt-get update
sudo apt install --install-recommends winehq-staging

# install lutris
echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_9.0/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_9.0/Release.key -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install lutris

#are these required?
#sudo apt-get install -y libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libsqlite3-0:i386 mesa-vulkan-drivers mesa-vulkan-drivers:i386

