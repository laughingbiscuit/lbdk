FROM debian:buster

WORKDIR /root
RUN apt-get update
RUN apt-get install -y git curl vim ranger libsdl1.2-dev libsdl-image1.2-dev libsdl-ttf2.0-dev libgtk2.0-dev libncursesw5 locales locales-all

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

RUN mkdir -p ~/games
RUN curl -sSL http://www.bay12games.com/dwarves/df_44_12_linux.tar.bz2 | tar -xvj -C ~/games
RUN echo "export LD_LIBRARY_PATH=/usr/lib/gcc/x86_64-linux-gnu/7/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
RUN sed -i "s/\[PRINT_MODE.*/[PRINT_MODE:TEXT]/i" /root/games/df_linux/data/init/init.txt
RUN rm /root/games/df_linux/libs/libgcc_s.so.1
RUN rm /root/games/df_linux/libs/libstdc++.so.6

RUN curl -sSLO https://github.com/DFHack/dfhack/releases/download/0.44.12-r2/dfhack-0.44.12-r2-Linux-64-gcc-7.tar.bz2 
RUN tar -xvjf dfhack-0.44.12-r2-Linux-64-gcc-7.tar.bz2 -C /root/games/df_linux

CMD bash /root/games/df_linux/dfhack
