mkdir -p $(pwd)/save
docker run --privileged -v$(pwd)/save:/root/games/df_linux/data/save/ -it lb/df
