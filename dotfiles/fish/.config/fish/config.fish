set CONFIG_LOG_LEVEL 0
status --is-login; and set CONFIG_LOG_LEVEL 1

if [ {$CONFIG_LOG_LEVEL} -gt 0 ]
  set_color grey
  set SHELL_START_DATE (gdate +%s%3N)
end

if [ {$CONFIG_LOG_LEVEL} -gt 2 ]
  echo "START : $SHELL_START_DATE"
  echo "PATH  : $PATH"
end

function time-me
  if [ {$CONFIG_LOG_LEVEL} -gt 2 ]
    set DATE (gdate +%s%3N)
    printf "    TIME : %20s : %s\n" $argv[1] (expr $DATE - $SHELL_START_DATE)
  end
end

if [ {$CONFIG_LOG_LEVEL} -gt 3 ]
  status --is-interactive; and echo "... INTERACTIVE shell"
  status --is-login; and echo "... LOGIN shell"
end

if status --is-login

  #
  # jenv set up
  #

  # equivalent of source (jenv init -|psub) with functions and completions
  # dotfiled
  set -gx JENV_SHELL fish
  set -gx JENV_LOADED 1

  #
  # rbenv set up
  #
  # equivalent of source (rbenv init -|psub) with functions and completions
  # dotfiled
  set -gx RBENV_SHELL fish

  # Point OMF state to dotfiles
  set -g OMF_CONFIG ~/.dotfiles/config/omf
end

if status --is-interactive
  time-me "BEFORE aliases"
  source ~/.config/fish/aliases.fish
  time-me "AFTER aliases"
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
  fish_vi_key_bindings
  #   fish_default_key_bindings
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

if [ {$CONFIG_LOG_LEVEL} -gt 2 ]
  time-me "END"
  echo "PATH = $PATH"
end
[ {$CONFIG_LOG_LEVEL} -gt 1 ] ;and echo "... Loaded ~/.config/fish/config.fish"
if [ {$CONFIG_LOG_LEVEL} -gt 0 ]
  set DATE (gdate +%s%3N)
  echo "... Initialised in "(expr $DATE - $SHELL_START_DATE)"ms"
  set_color normal
end
