export PATH=$HOME/.dotfiles/bin:$PATH

. ~/.config/sh/aliases.sh
. ~/.config/sh/aliases-non-fish.sh

# Vim bindings
bindkey -v

# Last command on "escape ."
bindkey '^[.' insert-last-word

if [ -f ~/.docker/init-zsh.sh ] ; then
  source ~/.docker/init-zsh.sh || true # Added by Docker Desktop
fi
