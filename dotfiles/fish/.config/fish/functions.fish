source ~/Library/Preferences/org.dystroy.broot/launcher/fish/br 

function fish_right_prompt
  #intentionally left blank
end
 
function git-reset-ssh-key
  ssh-add -D
  ssh-add -l
end

function git-set-personal-url
  set currentRemoteUrl (git config --get remote.origin.url)
  echo "Current remote URL = $currentRemoteUrl"
  set personalRemoteUrl (string replace 'github.com:' 'github.com-personal:' $currentRemoteUrl)
  if [ $currentRemoteUrl != $personalRemoteUrl ]
    git remote set-url origin $personalRemoteUrl
    echo "Changed repository remote URL to " (git config --get remote.origin.url)
  else 
    echo "Current repository already is using a personal URL"
  end
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

set PATH $HOME/.jenv/shims $PATH
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

echo "... Loaded ~/.config/fish/functions.fish" 
