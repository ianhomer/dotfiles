#
# jenv set up
#
set PATH $HOME/.jenv/bin $PATH
status --is-interactive; and source (jenv init -|psub)

#
# rbenv set up
#
status --is-interactive; and source (rbenv init - | psub)

set PATH ~/.dotfiles/bin $PATH

# Point OMF state to dotfiles
set -g OMF_CONFIG ~/.dotfiles/config/omf

if status --is-interactive
  source ~/.config/fish/aliases.fish
  source ~/.config/fish/functions.fish

  #
  # Tweak colors for me - noise reduction, red/green color blind and
  # long-sighted.
  #
  # execute `set | grep fish_color` to see colors in use in shell
  #
  set theme_color_scheme dark
  # Command in white for clarity on dark background
  set fish_color_command ffffff
  # red-green color blind friendly, red on dark background not good for me
  set fish_color_error 14b77b

  #
  # Work around for OSX issue causing
  # slow autocompletion - https://github.com/fish-shell/fish-shell/issues/6270
  #
  function __fish_describe_command; end

  #
  # key bindings
  #
  # * fish_vi_key_bindings -> vi key bindings
  # * fish_default_key_bindings -> default key bindings
  #
  fish_default_key_bindings
  # Time between escape key press and subsequent character
  set -g fish_escape_delay_ms 200

  echo "... Loaded ~/.cnfig/fish/config.fish"

  #
  # Set terminal for GPG to allow signining of git commits
  #
  set -x GPG_TTY (tty)
end
