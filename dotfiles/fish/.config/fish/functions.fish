source ~/Library/Preferences/org.dystroy.broot/launcher/fish/br

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

if status --is-login
  set PATH $HOME/.jenv/shims $PATH
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

#
# Load environment variables from a .env file
#
function dotenv
  set envFile (upfind .env)

  echo ".env file loaded : $envFile"
  if test -z "$envFile"
    echo "WARN : No env file found"
    exit 1
  end

  for i in (cat $envFile)
    set arr (echo $i |tr = \n)
    set -gx $arr[1] $arr[2]
  end
end

function docme
  if set -q argv[1]
    set fileName $argv[1]
    set autoOpen 0
  else
    set fileName $TMPDIR/docme.pdf
    echo "PDF : $fileName"
    set autoOpen 1
  end

  catmd | pandoc -s -d ~/.pandoc/pandoc -o $fileName
  if test $autoOpen -eq 1
    open $fileName
  end
end

if status --is-login
  echo "... Loaded ~/.config/fish/functions.fish"
end

