if status --is-interactive
  if [ {$DOT_LOG_LEVEL} -gt 0 ]
    set DATE (dateme +%s%3N)
    echo "◎ omf.fish @ "(expr $DATE - $SHELL_START_DATE)"ms"
  end

  # Path to Oh My Fish install.
  set -q XDG_DATA_HOME
    and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
    or set -gx OMF_PATH "$HOME/.local/share/omf"

  # Load Oh My Fish configuration.
  source $OMF_PATH/init.fish
end
