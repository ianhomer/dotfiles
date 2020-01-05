function git-reset-ssh-key
  ssh-add -D
  ssh-add -l
end

echo "... Loaded ~/.config/fish/functions.fish" 
