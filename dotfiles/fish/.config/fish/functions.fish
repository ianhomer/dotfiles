# Load broot alias
if test -f ~/Library/Preferences/org.dystroy.broot/launcher/fish/br
  source ~/Library/Preferences/org.dystroy.broot/launcher/fish/br
else if test -f ~/Library/Application\ Support/org.dystroy.broot/launcher/fish/br.fish
  echo "WARN : broot alias loaded from alternative location"
  source ~/Library/Application\ Support/org.dystroy.broot/launcher/fish/br.fish
end

time-me "AFTER broot"

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

function git-commit-and-push
  git commit -am "$argv"
  git push
end

function fish_user_key_bindings
  bind \cf forward-word
  bind \cb backward-word
end

function get-extension
  echo (string split -r -m1 . $argv)[2]
end

[ {$CONFIG_LOG_LEVEL} -gt 1 ] ;and \
  echo "... Loaded ~/.config/fish/functions.fish"

