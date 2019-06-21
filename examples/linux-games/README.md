# Linux Games

Installing Nethack locally
```
sudo apt-get install -y nethack-console
```

Install Dwarf Fortress (must be on a decent machine, and not on ARM)
```
sudo apt-get install -y libsdl1.2-dev libsdl-image1.2-dev libsdl-ttf2.0-dev
mkdir -p ~/games
curl -sSL http://www.bay12games.com/dwarves/df_44_12_linux.tar.bz2 | tar -xvj -C ~/games
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout -- ~/games/df_linux/
```

Install OSRS
```
mkdir -p ~/.jagex/runescape/bin
curl https://github.com/MrHDR/RaspberryPi/raw/master/Rsinstall/jagexappletviewer.jar

# to run
java -Xmx1024m -Djava.class.path=~/.jagex/runescape/bin/jagexappletviewer.jar -Dcom.jagex.config="http://oldschool.runescape.com/jav_config.ws" jagexappletviewer
```
