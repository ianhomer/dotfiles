set DOT_LOG_LEVEL 1
set DOT_TIME 0
set DOT_ALIASES 0

status --is-login; and set DOT_LOG_LEVEL 2
status --is-login; and set DOT_ALIASES 1

if [ {$DOT_LOG_LEVEL} -gt 0 ]
  status --is-interactive; and set_color grey
  set SHELL_START_DATE (dateme +%s%3N)
end

if [ {$DOT_LOG_LEVEL} -gt 2 ] 
  set DOT_TIME 1
end

if [ {$DOT_LOG_LEVEL} -gt 2 ]
  echo "START : $SHELL_START_DATE"
  echo "PATH  : $PATH"
end


