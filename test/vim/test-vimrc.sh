#!/usr/bin/env bash

set -e

COMMAND=vim
while getopts "c:" o; do case "$o" in
  c) COMMAND=$OPTARG ;;
esac done

echo "Running tests with : $COMMAND"

case $COMMAND in
  vim)
    PLUGIN_DIR=.config/nvim/plugged
    ;;
  nvim)
    PLUGIN_DIR=.config/nvim/plugged
    ;;
  *)
    echo "Vim variant $COMMAND not recognised"
    exit 1
esac

# use local plugin directory if it exists, otherwise assume it's relative to
# home.
if [[ ! -d $PLUGIN_DIR ]] ; then
  PLUGIN_DIR=$HOME/$PLUGIN_DIR
fi
echo $PLUGIN_DIR
ls $PLUGIN_DIR
ls $PLUGIN_DIR/vader.vim

$COMMAND --version
$COMMAND -Nu <(cat << EOF
filetype off
set rtp+=$PLUGIN_DIR/vader.vim
filetype plugin indent on
syntax enable
EOF
) -c 'Vader! ./test/vim/*.vader' > vader.log

cat vader.log
