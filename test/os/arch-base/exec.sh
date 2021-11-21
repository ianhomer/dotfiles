#!/usr/bin/env bash

#
# Slim end to end test

docker build -t local/arch-base -f Dockerfile .
docker run --rm -it local/arch-base



