# Thanks to https://github.com/dideler/dotfiles
function add_to_user_path --description "Persistently prepends to your PATH via fish_user_paths"
  for path in $argv
    if not contains $path $fish_user_paths
      echo "Adding $path to universal path"
      set --universal fish_user_paths $path $fish_user_paths
    else
      echo "Not adding $path to universal path, it is already in $fish_user_paths"
    end
  end
end

