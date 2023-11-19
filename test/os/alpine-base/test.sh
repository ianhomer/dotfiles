#!/usr/bin/env sh

#
# Slim end to end test

docker build -t local/alpine-base -f Dockerfile .
docker run --rm -it -v $HOME/.dotfiles:/root/.dotfiles local/alpine-base


