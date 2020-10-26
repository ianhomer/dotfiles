#!/usr/bin/env bash

COMMAND=nvim
while getopts "c:" o; do case "$o" in
  c) COMMAND=$OPTARG ;;
esac done

echo "Running tests with : $COMMAND"

case $COMMAND in
  vim)
    PLUGIN_DIR=$HOME/.config/$COMMAND
    ;;
  nvim)
    PLUGIN_DIR=$HOME/.config/$COMMAND/plugged
    ;;
  *)
    echo "Vim variant $COMMAND not recognised"
    exit 1
esac

ls $HOME
echo $PLUGIN_DIR
ls $PLUGIN_DIR

$COMMAND -Nu <(cat << EOF
filetype off
set rtp+=$PLUGIN_DIR/vader.vim
set rtp+=.
set rtp+=after
filetype plugin indent on
syntax enable
EOF
) -c 'Vader! ./test/vim/*.vader' > vader.log 

cat vader.log
