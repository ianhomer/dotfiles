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

#
# Run vim (or neovim) with the given configuration
# Note that we redirect output with redir since directing nvim output to
# /dev/null as per vader documentation leads to a core dump in Github actions.
# We also capture stderr into a file and cat that because without it 
# we don't see the output when run locally.
#

$COMMAND -Nu <(cat << EOF
filetype off
set rtp+=$PLUGIN_DIR/vader.vim
filetype plugin indent on
EOF) 'redir! > vim-out.log' +'Vader! ./test/vim/*.vader' 2>vim-error.log
cat vim-out.log
cat vim-error.log
