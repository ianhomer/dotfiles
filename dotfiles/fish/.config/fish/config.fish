[ {$DOT_SKIP} -eq 2 ]; and exit

time-me "START config.fish"

if [ {$DOT_LOG_LEVEL} -gt 1 ]
  set DATE (dateme +%s%3N)
  echo "◎ in config.fish @ "(expr $DATE - $SHELL_START_DATE)"ms"
end

if [ {$DOT_LOG_LEVEL} -gt 3 ]
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

  # Use fd for fzf by default
  set -gx FZF_DEFAULT_COMMAND 'fd --type f'

  # nnn set up

  set -x NNN_FCOLORS 'E63100'
  set -x NNN_PLUG 'b:bookmarks;c:fzcd;p:preview-tui;f:fzopen'
  set -x NNN_FIFO "/tmp/nnn.fifo"
  set -x VISUAL ewrap
end

if status --is-interactive
  time-me "BEFORE aliases"
  source ~/.config/fish/aliases.fish
  time-me "AFTER aliases"
  source ~/.config/fish/functions.fish
  set DATE (dateme +%s%3N)
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

  #
  # Tweak colors for me - noise reduction, red/green color blind and
  # long-sighted.
  #
  # execute `set | grep fish_color` to see colors in use in shell
  #
  if [ "$BG_MODE" = "light" ]
    set fish_color_command 000000
  else
    set theme_color_scheme dark
    # Command in white for clarity on dark background
    set fish_color_command ffffff
    # red-green color blind friendly, red on dark background not good for me
    set fish_color_error 14b77b
  end
end

time-me "AFTER bindings"

if status --is-login
  #
  # Set terminal for GPG to allow signining of git commits
  #
  set -x GPG_TTY (tty)
end

time-me "AFTER colors"

if [ {$DOT_LOG_LEVEL} -gt 2 ]
  echo "PATH = $PATH"
end

[ {$DOT_LOG_LEVEL} -gt 1 ] ;and echo "◎ loaded ~/.config/fish/config.fish"

if [ {$DOT_LOG_LEVEL} -gt 0 ]
  set DATE (dateme +%s%3N)
  echo "◎ up in "(math $DATE - $SHELL_START_DATE)"ms"
  status --is-interactive; and set_color normal
end

# Things bind

bind \ct things
bind --mode insert \ct things

time-me "END config.fish"


