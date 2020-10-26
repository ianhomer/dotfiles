#!/usr/bin/env bash

echo "Running tests"

PLUGIN_DIR=~/.config/nvim/plugged

vim -Nu <(cat << VIMRC
filetype off
set rtp+=$PLUGIN_DIR/vader.vim
set rtp+=.
set rtp+=after
filetype plugin indent on
syntax enable
VIMRC) -c 'Vader! *.vader' > /dev/null
