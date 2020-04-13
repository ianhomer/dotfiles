set CONFIG_LOG_LEVEL 0
status --is-login; and set CONFIG_LOG_LEVEL 1
set CONFIG_LOG_LEVEL 3

if [ {$CONFIG_LOG_LEVEL} -gt 1 ]
  set START_DATE (gdate +%s%3N)
  echo "START : $START_DATE"
  echo "PATH  : $PATH"

  function time-me
    set DATE (gdate +%s%3N)
    printf "    TIME : %20s : %s\n" $argv[1] (expr $DATE - $START_DATE)
  end
end
if [ {$CONFIG_LOG_LEVEL} -gt 2 ]
  status --is-interactive; and echo "... INTERACTIVE shell"
  status --is-login; and echo "... LOGIN shell"
end

if status --is-login

  #
  # jenv set up
  #

  source (jenv init -|psub)

  #
  # rbenv set up
  #
  source (rbenv init -|psub)

  # Point OMF state to dotfiles
  set -g OMF_CONFIG ~/.dotfiles/config/omf
end

if status --is-interactive
  time-me "BEFORE aliases"
  source ~/.config/fish/aliases.fish
  source ~/.config/fish/functions.fish
  set DATE (gdate +%s%3N)
  time-me "AFTER functions"

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
end

if status --is-login
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
  # Set terminal for GPG to allow signining of git commits
  #
  set -x GPG_TTY (tty)
end

if [ {$CONFIG_LOG_LEVEL} -gt 1 ]
  time-me "END"
  echo "PATH = $PATH"
end
[ {$CONFIG_LOG_LEVEL} -gt 0 ] ;and echo "... Loaded ~/.config/fish/config.fish"

