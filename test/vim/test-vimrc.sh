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

pwd
ls

$COMMAND --version
$COMMAND -u NONE +'redir! > vim-out.log' +'echo "hello1"' +quit
cat vim-out.log

$COMMAND -Nu NONE +'redir! > vim-out.log' +'echo "hello2"' +quit
cat vim-out.log

$COMMAND -Nu <(cat << EOF
EOF) +'redir! > vim-out.log' +'echo "hello3"' +quit
cat vim-out.log

echo "cat EOF 1"
$COMMAND -Nu <(cat << EOF
EOF) +'redir! > vim-out.log' +'echo "hello4"' +quit
cat vim-out.log

echo "echo vimrc"
$COMMAND -Nu <(echo "set ignorecase")\
  +'redir! > vim-out.log' +'echo "hello4a"' +quit
cat vim-out.log

cat << EOF > tmp-vimrc.vim
set ignorecase
EOF

cat tmp-vimrc.vim

#od -x tmp-vimrc.vim

#echo "tmp vimrc"
#$COMMAND -u tmp-vimrc.vim +'redir! > vim-out.log' +'echo "hello7"' +quit > /dev/null
#cat vim-out.log
#
#echo "cat EOF 2"
#$COMMAND -u <(cat << EOF
#filetype off
#EOF) +'redir! > vim-out.log' +'echo "hello8"' +quit > /dev/null
#cat vim-out.log
#
#
#echo "cat EOF 3"
#$COMMAND -u <(cat << EOF
#set rtp+=$PLUGIN_DIR/vader.vim
#EOF) +'redir! > vim-out.log' +'echo "hello7"' +quit > /dev/null
#cat vim-out.log
#
#echo "rtp"
#$COMMAND -Nu <(cat << EOF
#filetype off
#set rtp+=$PLUGIN_DIR/vader.vim
#filetype plugin indent on
#EOF) +'redir! > vim-out.log' +'echo "hello8"' +quit > /dev/null
#cat vim-out.log
#
#echo "Vader"
#$COMMAND -Nu <(cat << EOF
#filetype off
#set rtp+=$PLUGIN_DIR/vader.vim
#filetype plugin indent on
#EOF) +'redir! > vim-out.log' +'Vader! ./test/vim/*.vader' > /dev/null
#cat vim-out.log
#
#echo "quit (pre-old way)"
#$COMMAND -Nu <(cat << EOF
#filetype off
#set rtp+=$PLUGIN_DIR/vader.vim
#filetype plugin indent on
#EOF) +'redir! > vim-out.log' +quit > /dev/null
#cat vim-out.log
#
#echo "quit (old way)"
#$COMMAND -Nu <(cat << EOF
#filetype off
#set rtp+=$PLUGIN_DIR/vader.vim
#filetype plugin indent on
#EOF) +quit > /dev/null
#
#echo "vader (old way)"
#$COMMAND -Nu <(cat << EOF
#filetype off
#set rtp+=$PLUGIN_DIR/vader.vim
#filetype plugin indent on
#EOF) -c "Vader! ./test/vim/*.vader" > /dev/null

$COMMAND -Nu <(cat << EOF
filetype off
set rtp+=$PLUGIN_DIR/vader.vim
filetype plugin indent on
EOF) +'Vader! ./test/vim/*.vader' +quit
