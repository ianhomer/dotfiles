# Load broot alias
if test -f ~/Library/Preferences/org.dystroy.broot/launcher/fish/br
  source ~/Library/Preferences/org.dystroy.broot/launcher/fish/br
else if test -f ~/Library/Application\ Support/org.dystroy.broot/launcher/fish/br.fish
  if [ {$CONFIG_LOG_LEVEL} -gt 0 ]
    echo "... WARN : broot alias loaded from alternative location"
  end
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

function pull
  git pull
end

function master
  git checkout master
  git pull
end

function feature
  set branchName feature/$argv
  if git rev-parse -q --verify $branchName
    # Branch already exists, check it out
    printf "\033[0;35mChecking out branchName\n\033[0m"
    git checkout feature/$argv
  else
    printf "\033[0;35mCreating $branchName\n\033[0m"
    # Ensure we're branching off latest master
    master
    git checkout -b $branchName
    git push -u
  end
end

[ {$CONFIG_LOG_LEVEL} -gt 1 ] ;and \
  echo "... Loaded ~/.config/fish/functions.fish"

