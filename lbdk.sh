#!/bin/sh

set -e

apk update
apk add \
    busybox-extras \
    curl \
    docker \
    git \
    jq \
    lastpass-cli \
    less \
    libressl \
    lynx \
    man \
    man-pages \
    nnn \
    nodejs \
    npm \
    openssh \
    tmux
    
