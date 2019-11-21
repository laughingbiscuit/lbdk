#!/bin/bash

mkdir -p $(pwd)/save
docker build -t lb/df .
docker run --privileged -v$(pwd)/save:/home/someuser/games/df_linux/data/save -it lb/df
