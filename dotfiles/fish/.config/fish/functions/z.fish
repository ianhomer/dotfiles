# Simplified z for only use case I need. i.e. Type z then first few characters
# of directory I want ; then tab to use fish complete ; then return to change to
# directory.
function z -d "Change directory relying on fasd completion"
  # If no argument then fuzzy find directory
  if [ -z "$argv" ]
    set dir (fasd -ld | fzf)
    # If empty then return
    if [ -z "$dir" ]
      return
    end
  else
    set dir $argv
  end
  cd $dir
end
