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

echo "... Loaded ~/.config/fish/functions.fish" 
