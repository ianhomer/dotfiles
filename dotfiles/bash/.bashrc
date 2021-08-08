echo "... running ~/.bashrc from dotfiles"

if command -v fasd &> /dev/null ; then
  # Initialise fasd https://github.com/clvv/fasd
  fasd_cache="$HOME/.fasd-init-bash"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache
fi


# Initialise broot
if [[ "$OSTYPE" =~ ^darwin ]]; then
  source ~/Library/Preferences/org.dystroy.broot/launcher/bash/br
  source /Users/ian/Library/Preferences/org.dystroy.broot/launcher/bash/br
fi

if [[ -x thefuck ]] ; then
  eval "$(thefuck --alias)"
  alias fck="fuck"
fi

# FZF better with fd
export FZF_DEFAULT_COMMAND='fd --type f'

# neovim is the new vim
alias vi="VIM_KNOB=5 nvim"
alias v="VIM_KNOB=5 nvim"
alias pull="git pullme"
