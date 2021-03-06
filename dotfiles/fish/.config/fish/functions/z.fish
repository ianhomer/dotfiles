# Simplified z for only use case I need. i.e. Type z then first few characters
# of directory I want ; then tab to use fish complete ; then return to change to
# directory.
function z -d "Change directory relying on fasd completion"
  cd $argv
end
