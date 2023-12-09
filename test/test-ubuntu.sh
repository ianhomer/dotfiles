#!/bin/sh

#
# Sanity test for ubuntu
#
set -e

$(shim)
cd ${DOTFILES_DIR}
docker build -t local/ubuntu-dotfiles -f test/os/ubuntu/Dockerfile .
docker run --rm -it local/ubuntu-dotfiles /bin/bash
