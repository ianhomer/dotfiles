status --is-interactive; and source (rbenv init - | psub)

set PATH ~/.dotfiles/bin $PATH

# Point OMF state to dotfiles
set -g OMF_CONFIG ~/.dotfiles/config/omf

if status --is-interactive
  source ~/.config/fish/aliases.fish
  source ~/.config/fish/functions.fish

  # Tweak colors for me - noise reduction, red/green color blind and 
  # long-sighted.
  # execute `set | grep fish_color` to see colors in use in shell
  set theme_color_scheme dark

  # Command in white for clarity on dark background
  set fish_color_command ffffff
  # red-green color blind friendly, red on dark background not good for me
  set fish_color_error 14b77b

  # Work around for OSX issue causing 
  # slow autocompletion - https://github.com/fish-shell/fish-shell/issues/6270
  function __fish_describe_command; end

  # use vi key bindings, go back to default key bindings 
  # with fish_default_key_bindings 
  fish_vi_key_bindings
  echo "... Loaded ~/.cnfig/fish/config.fish"

  # Set terminal for GPG to allow signining of git commits 
  set -x GPG_TTY (tty)
end
