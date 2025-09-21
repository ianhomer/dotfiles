if [[ -f "$HOME/.cargo/env" ]] ; then
  . "$HOME/.cargo/env"
fi

export PATH=$HOME/.dotfiles/bin:$PATH

export EDITOR="nvim"
export VISUAL="nvim"

# History file at ~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
