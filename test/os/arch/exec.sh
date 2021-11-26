#!/usr/bin/env bash

#
# Slim end to end test

set -e
cd ~/.dotfiles
docker build -t local/arch-me -f Dockerfile .
docker run --rm -it local/arch-me


