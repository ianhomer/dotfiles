# Whether to load aliases
set DOT_ALIASES 0
# Whether to load functions
set DOT_FUNCTIONS 0
# Log levels
set DOT_LOG_LEVEL 1
# Report on time profiling
set DOT_TIME 0
# 1 => skip some ; 2 => skip all
set DOT_SKIP 0

if [ {$DOT_LOG_LEVEL} -gt 0 ]
  status --is-interactive; and set_color grey
  set SHELL_START_DATE (dateme +%s%3N)
end

[ {$DOT_SKIP} -eq 2 ]; and exit

if status --is-login
  set DOT_LOG_LEVEL 1
  set DOT_ALIASES 1
  set DOT_FUNCTIONS 1
end

if [ {$DOT_LOG_LEVEL} -gt 2 ]
  set DOT_TIME 1
  echo "START : $SHELL_START_DATE"
  echo "PATH  : $PATH"
end

# Optimised dateme function
switch (uname)
  case Darwin
    function dateme
      gdate $argv 
    end
  case '*'
    function dateme
      date $argv
    end
end

function time-me
  if [ {$DOT_TIME} -gt 0 ]
    set DATE (dateme +%s%3N)
    printf "⨂ %20s : %4sms\n" $argv[1] (expr $DATE - $SHELL_START_DATE)
  end
end

