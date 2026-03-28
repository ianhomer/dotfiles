set -q DOT_TIME; or set DOT_TIME 0

function time-me
    if [ {$DOT_TIME} -eq 1 ]
        set DATE (dateme +%s%3N)
        printf "⨂ %-20s : %4sms\n" $argv[1] (math $DATE - $SHELL_START_DATE)
    end
end
