function cd -d "Register directory and change to directory"
  # If no argument then fuzzy find directory
  if [ -z "$argv" ]
    set dir (fd -t d | fzf)
    # If empty then return
    if [ -z "$dir" ]
      return
    end
  else
    set dir $argv
  end
  fasd -A $dir
  builtin cd $dir
end
