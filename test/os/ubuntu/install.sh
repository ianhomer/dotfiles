#!/usr/bin/env bash

set -e

apt-get update
apt install -y wget make neovim git
mkdir -p /home/runner/nvim

cd /home/runner/nvim
wget \
  https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz \
  -P /tmp
/bin/tar xzf /tmp/nvim-linux64.tar.gz
mkdir -p /home/runner/nvim/bin
ln -s /home/runner/nvim/nvim-linux64/bin/nvim \
  /home/runner/nvim/bin/nvim

git clone https://github.com/ianhomer/dotfiles.git \
  ~/.dotfiles
git clone https://github.com/junegunn/vader.vim.git \
  ~/.dotfiles/tmp/vim/plugins/vader.vim

export VIM_COMMAND=/home/runner/nvim/bin/nvim
cd ~/.dotfiles

