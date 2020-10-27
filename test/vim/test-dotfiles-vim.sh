#!/usr/bin/env bash

set -e

COMMAND=${VIM_COMMAND:-nvim}

while getopts "c:" o; do case "$o" in
  c) COMMAND=$OPTARG ;;
esac done

echo "Running tests with : $COMMAND"

PLUGIN_DIR=./tmp/vim/plugins

# use local plugin directory if it exists, otherwise assume it's relative to
# home.
if [[ ! -d $PLUGIN_DIR ]] ; then
  PLUGIN_DIR=$HOME/$PLUGIN_DIR
fi
echo $PLUGIN_DIR

$COMMAND --version

echo "Running Vader tests"

$COMMAND -Nu <(cat << EOF
filetype off
set rtp+=$PLUGIN_DIR/vader.vim
filetype plugin indent on
EOF
) +'redir! > vim-out.log' +'Vader! ./test/vim/*.vader'
cat vim-out.log
