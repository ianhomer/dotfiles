set CONFIG_LOG_LEVEL 1
set PROFILE_TIME 0
set ENABLE_ALIASES 0

status --is-login; and set CONFIG_LOG_LEVEL 2
status --is-login; and set ENABLE_ALIASES 1

if [ {$CONFIG_LOG_LEVEL} -gt 0 ]
  set_color grey
  set SHELL_START_DATE (dateme +%s%3N)
end

if [ {$CONFIG_LOG_LEVEL} -gt 2 ] 
  set PROFILE_TIME 1
end

if [ {$CONFIG_LOG_LEVEL} -gt 2 ]
  echo "START : $SHELL_START_DATE"
  echo "PATH  : $PATH"
end


