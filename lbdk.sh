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
    mandoc \
    man-pages \
    nnn \
    nodejs \
    npm \
    openssh \
    tmux
    
