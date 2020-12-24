#!/usr/bin/env bash

#
# Sanity test for dotfiles
#
set -e

$(shim)
cd ${DOTFILES_DIR}
docker build -t local/arch-slim -f Dockerfile .
docker run --rm -it local/arch-slim /bin/bash --init-file '.boot.bashrc.sh'
