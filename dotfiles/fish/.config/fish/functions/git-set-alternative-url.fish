function git-set-alternative-url
  if set -q argv[1]
    set name $argv[1]
  else
    set name "personal"
  end

  set currentRemoteUrl (git config --get remote.origin.url)
  echo "... current remote URL = $currentRemoteUrl"
  switch $currentRemoteUrl
  case "*github.com*"
    set host "github.com"
  case "*bitbucket.org*"
    set host "bitbucket.org"
  case "*"
    echo "Host for current remote URL not recognised"
    exit 1
  end
  set alternativeRemoteUrl (string replace "$host:" "$host-$name:" $currentRemoteUrl)

  echo "... alternative remote URL $alternativeRemoteUrl"
  if [ $currentRemoteUrl != $alternativeRemoteUrl ]
    git remote set-url origin $alternativeRemoteUrl
    echo "Changed repository remote URL to " (git config --get remote.origin.url)
  else
    echo "Current repository already is using a alternative URL"
  end
end
