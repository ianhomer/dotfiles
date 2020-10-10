set CONFIG_LOG_LEVEL 0
status --is-login; and set CONFIG_LOG_LEVEL 1

if [ {$CONFIG_LOG_LEVEL} -gt 0 ]
  set_color grey
  set SHELL_START_DATE (dateme +%s%3N)
end

if [ {$CONFIG_LOG_LEVEL} -gt 2 ]
  echo "START : $SHELL_START_DATE"
  echo "PATH  : $PATH"
end


