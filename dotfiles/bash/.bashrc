echo "... running ~/.bashrc from dotfiles"

# Initialise fasd https://github.com/clvv/fasd
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# Initialise broot
if ~/.dotfiles/bin/is-pc; then
  source ~/Library/Preferences/org.dystroy.broot/launcher/bash/br
  source /Users/ian/Library/Preferences/org.dystroy.broot/launcher/bash/br
fi
