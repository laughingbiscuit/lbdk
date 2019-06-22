#!/bin/bash
java -Xmx1024m -Djava.class.path=$HOME/.jagex/runescape/bin/jagexappletviewer.jar -Dcom.jagex.config="http://oldschool.runescape.com/jav_config.ws" jagexappletviewer $HOME/.jagex/runescape/images
