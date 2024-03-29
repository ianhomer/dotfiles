#!/usr/bin/env bash

_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
set -e

#${COMMAND} -u test/vim/gruvbox-rc.vim \
#  --noplugin \
#  --startuptime vim.log \
#  +q

cd ${_DIR}
if [ ! -d tmp/vim/test/opt/gruvbox ] ; then
  git clone https://github.com/morhetz/gruvbox.git \
    tmp/vim/test/opt/gruvbox
fi


[ -f vim-startup.log ] && rm vim-startup.log
vim --noplugin \
  --startuptime vim-startup.log \
  +q -Nu <(cat << EOF
set rtp+=tmp/vim/test/opt/gruvbox
colorscheme gruvbox
EOF
)

echo
echo "vim : colorscheme gruvbox"
echo

cat vim-startup.log | grep 'color\|editing'

rm vim-startup.log
nvim --noplugin \
  --startuptime vim-startup.log \
  +q -Nu <(cat << EOF
colorscheme gruvbox
EOF
)

echo
echo "neovim : colorscheme gruvbox"
echo

cat vim-startup.log | grep 'color\|editing'

rm vim-startup.log
nvim --noplugin \
  --startuptime vim-startup.log \
  +q -Nu <(cat << EOF
let g:colors_name='gruvbox'
EOF
)

echo
echo "neovim : g:colors_name gruvbox"
echo
cat vim-startup.log | grep 'color\|editing'

rm vim-startup.log
nvim --noplugin \
  --startuptime vim-startup.log \
  +q -Nu <(cat << EOF
colorscheme default
EOF
)

echo
echo "neovim : colorscheme default"
echo

cat vim-startup.log | grep 'color\|editing'


