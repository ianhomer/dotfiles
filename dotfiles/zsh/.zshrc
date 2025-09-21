. ~/.config/sh/aliases.sh
. ~/.config/sh/aliases-non-fish.sh

# Initialise completion
autoload -U compinit; compinit

fpath=(~/.zsh/plugins $fpath)

autoload -Uz my-prompt.zsh ; my-prompt.zsh
autoload -Uz my-cursor.zsh ; my-cursor.zsh

# Vim bindings
bindkey -v
# Long enough for esc-. to still work to insert last word
export KEYTIMEOUT=1000

# Last command on "escape ."
bindkey '^[.' insert-last-word

# FZF bindings, e.g. reverse history search (ctrl-r)
source <(fzf --zsh)

if [ -f ~/.docker/init-zsh.sh ] ; then
  source ~/.docker/init-zsh.sh || true # Added by Docker Desktop
fi
