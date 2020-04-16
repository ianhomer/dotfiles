# Thanks to https://github.com/dideler/dotfiles
function add-to-universal-path --description "Persistently prepends to your PATH via fish_user_paths"
  for path in $argv
    if not contains $path $fish_user_paths
      echo "Adding to universal path : $path"
      set --universal fish_user_paths $path $fish_user_paths
    else
      echo "Already in universal path : $path"
    end
  end
end

