# If not running interactively, don't do anything

[ -z "$PS1" ] && return

echo "... running .bash_profile from dotfiles"

PATH=$PATH:$HOME/.dotfiles/bin
. "$HOME/.cargo/env"
