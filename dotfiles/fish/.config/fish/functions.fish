# Load broot alias
if test -f ~/Library/Preferences/org.dystroy.broot/launcher/fish/br
  source ~/Library/Preferences/org.dystroy.broot/launcher/fish/br
else if test -f ~/Library/Application\ Support/org.dystroy.broot/launcher/fish/br.fish
  echo "WARN : broot alias loaded from alternative location"
  source ~/Library/Application\ Support/org.dystroy.broot/launcher/fish/br.fish
else
  echo "WARN : Cannot load broot alias"
end

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

function git-reset-ssh-key
  ssh-add -D
  ssh-add -l
end

function git-commit-and-push
  git commit -am "$argv"
  git push
end

function fish_user_key_bindings
  bind \cf forward-word
  bind \cb backward-word
end

#
# jenv support
#
function export
  set arr (echo $argv|tr = \n)
  set -gx $arr[1] $arr[2]
end

command jenv rehash 2>/dev/null
function jenv
  set cmd $argv[1]
  set arg ""
  if test (count $argv) -gt 1
    # Great... fish first array index is ... 1 !
    set arg $argv[2..-1]
  end

  switch "$cmd"
    case enable-plugin rehash shell shell-options
        set script (jenv "sh-$cmd" "$arg")
        eval $script
    case '*'
        command jenv $cmd $arg
    end
end

if status --is-login
  echo "... Loaded ~/.config/fish/functions.fish"
end

