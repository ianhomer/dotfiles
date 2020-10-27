#!/usr/bin/env bash

set -e

echo $VIM_COMMAND

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
ls $PLUGIN_DIR
ls $PLUGIN_DIR/vader.vim

$COMMAND --version
$COMMAND -u NONE +'redir! > vim-out.log' +'echo "hello"' +quit
cat vim-out.log

$COMMAND -Nu NONE +'redir! > vim-out.log' +'echo "hello"' +quit
cat vim-out.log

$COMMAND -Nu <(cat << EOF
EOF) +'redir! > vim-out.log' +'echo "hello"' +quit
cat vim-out.log

$COMMAND -Nu <(cat << EOF
EOF) +'redir! > vim-out.log' +'echo "hello"' +quit
cat vim-out.log

$COMMAND -Nu <(cat << EOF
filetype off
filetype plugin indent on
EOF) +'redir! > vim-out.log' +'echo "hello"' +quit
cat vim-out.log

echo "rtp"
$COMMAND -Nu <(cat << EOF
filetype off
set rtp+=$PLUGIN_DIR/vader.vim
filetype plugin indent on
EOF) +'redir! > vim-out.log' +'echo "hello"' +quit
cat vim-out.log

echo "Vader"
$COMMAND -Nu <(cat << EOF
filetype off
set rtp+=$PLUGIN_DIR/vader.vim
filetype plugin indent on
EOF) +'redir! > vim-out.log' +'Vader! ./test/vim/*.vader"'
cat vim-out.log

#$COMMAND -Nu <(cat << EOF
#filetype off
#filetype plugin indent on
#EOF) -c "quit" > /dev/null
#) -c "Vader! ./test/vim/*.vader" > vader.log

