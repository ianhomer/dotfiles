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

# Load broot alias
if test -f ~/Library/Preferences/org.dystroy.broot/launcher/fish/br
  source ~/Library/Preferences/org.dystroy.broot/launcher/fish/br
else if test -f ~/Library/Application\ Support/org.dystroy.broot/launcher/fish/br.fish
  if [ {$DOT_LOG_LEVEL} -gt 0 ]
    echo "‼︎ broot alias loaded from alternative location"
  end
  source ~/Library/Application\ Support/org.dystroy.broot/launcher/fish/br.fish
end

time-me "AFTER broot"

function fish_user_key_bindings
  bind \cf forward-word
  bind \cb backward-word
end

[ {$DOT_LOG_LEVEL} -gt 1 ] ;and \
  echo "◎ loaded ~/.config/fish/functions.fish"
