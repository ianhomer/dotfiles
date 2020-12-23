#!/usr/bin/env bash

#
# Sanity test for dotfiles
#
set -e

_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd ${_DIR}/..
docker build -t local/arch-slim -f Dockerfile .
docker run --rm -it local/arch-slim /bin/bash
