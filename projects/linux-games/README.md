# Linux Games

Installing Nethack locally
```
sudo apt-get install -y nethack-console
```

Run Dwarf Fortress with DF Hack in [Docker](https://hub.docker.com/r/laughingbiscuit/dwarffortress)
```
mkdir -p $(pwd)/save
docker run --privileged -v$(pwd)/save:/home/someuser/games/df_linux/data/save -it laughingbiscuit/dwarffortress
```


Install OSRS
```
mkdir -p ~/.jagex/runescape/bin
mkdir -p ~/.jagex/runescape/images
curl -L https://github.com/MrHDR/RaspberryPi/raw/master/Rsinstall/jagexappletviewer.jar -o ~/.jagex/runescape/bin/jagexappletviewer.jar

# to run
java -Xmx1024m -Djava.class.path=$HOME/.jagex/runescape/bin/jagexappletviewer.jar -Dcom.jagex.config="http://oldschool.runescape.com/jav_config.ws" jagexappletviewer $HOME/.jagex/runescape/images
```
