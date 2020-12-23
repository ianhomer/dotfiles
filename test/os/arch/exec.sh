#!/usr/bin/env bash

docker build -t local/arch-me -f Dockerfile .
docker run --rm -it local/arch-me


