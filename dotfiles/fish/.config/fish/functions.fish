[ {$DOT_SKIP} -eq 2 ]; and exit

if not status --is-login
    function fish_greeting
        #intentionally left blank
    end

    #
    # If terminal called from within vim, then keep it simple
    #
    if [ -n "$VIM" ]
        function fish_prompt
            echo " > "
        end
    end
end

function fish_right_prompt
    #intentionally left blank
end

[ {$DOT_FUNCTIONS} -eq 0 ]; and exit

time-me "AFTER broot"

[ {$DOT_LOG_LEVEL} -gt 1 ]; and echo "◎ loaded ~/.config/fish/functions.fish"
