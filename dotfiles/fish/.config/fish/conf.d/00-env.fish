# Whether to load aliases
set DOT_ALIASES 0
# Whether to load functions
set DOT_FUNCTIONS 0
# Log levels
set DOT_LOG_LEVEL 0
# Report on time profiling
set DOT_TIME 0
# 1 => skip some ; 2 => skip all
set DOT_SKIP 0

if status --is-login
    set DOT_LOG_LEVEL 1
    set DOT_ALIASES 1
    set DOT_FUNCTIONS 1
else if status --is-interactive
    set DOT_LOG_LEVEL 1
    set DOT_ALIASES 1
end

if [ {$DOT_LOG_LEVEL} -gt 2 ]
    set DOT_TIME 1
    echo "START : $SHELL_START_DATE"
    echo "PATH  : $PATH"
end

if [ {$DOT_LOG_LEVEL} -gt 0 ]
    status --is-interactive; and set_color grey
end

[ {$DOT_TIME} ]; and set SHELL_START_DATE (dateme +%s%3N)
