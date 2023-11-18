# .bash_profile is run when we either log in or start up a new terminal
# app with bash as the default shell

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

echo "... running .bash_profile from dotfiles"

PATH=$PATH:$HOME/.dotfiles/bin

if [[ `uname` == 'Darwin' ]] ; then
  if [[ `uname -m` == 'arm64' ]]; then
    # Silicon
    PATH=$PATH:/opt/homebrew/bin
  else
    echo "WARN : default non-silicon homebrew path when this is run on non-silicon"
  fi
fi

source ~/.bashrc
. "$HOME/.cargo/env"
