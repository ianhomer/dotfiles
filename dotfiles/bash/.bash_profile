# If not running interactively, don't do anything

[ -z "$PS1" ] && return

echo "... running .bash_profile from dotfiles"

PATH=$PATH:~/.dotfiles/bin

if is-pc; then
  source /Users/ian/Library/Preferences/org.dystroy.broot/launcher/bash/br
fi
