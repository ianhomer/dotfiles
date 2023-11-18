# .bashrc is executed each time shell starts
echo "... running ~/.bashrc from dotfiles"

if command -v fasd &> /dev/null ; then
  # Initialise fasd https://github.com/clvv/fasd
  fasd_cache="$HOME/.fasd-init-bash"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
  fi
  source ~/.fasd-init-bash
  unset fasd_cache
fi

# Inline br function, this comes from
# /Users/ian/Library/Application\ Support/org.dystroy.broot/launcher/bash/1
# which comes from the broot --install process see
# https://dystroy.org/broot/documentation/installation
function br {
    local cmd cmd_file code
    cmd_file=$(mktemp)
    if broot --outcmd "$cmd_file" "$@"; then
        cmd=$(<"$cmd_file")
        rm -f "$cmd_file"
        eval "$cmd"
    else
        code=$?
        rm -f "$cmd_file"
        return "$code"
    fi
}

if [[ -x thefuck ]] ; then
  eval "$(thefuck --alias)"
  alias fck="fuck"
fi

# FZF better with fd
export FZF_DEFAULT_COMMAND='fd --type f'

export NVM_DIR="$HOME/.nvm"
# with --no-use we postpone nvm until we use it so we can take explicit
# control
if [[ -f ~/.nvm/nvm.sh ]] ; then
  . ~/.nvm/nvm.sh --no-use
  # . ~/.nvm/bash_completion.d/nvm
fi

. ~/.config/sh/aliases.sh
. ~/.config/sh/aliases-non-fish.sh

# neovim is the new vim
. ~/.config/sh/aliases.sh
. ~/.config/sh/aliases-non-fish.sh
. ~/.cargo/env

if [[ -f ~/.docker/init-bash.sh ]] ; then
  source ~/.docker/init-bash.sh || true # Added by Docker Desktop
fi
