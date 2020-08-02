" set up folding of quickfix list
" thanks to https://vim.fandom.com/wiki/Fold_quickfix_list_on_directory_or_file_names

setlocal foldmethod=expr
setlocal foldexpr=matchstr(getline(v:lnum),'^[^\|]\\+')==#matchstr(getline(v:lnum+1),'^[^\|]\\+')?1:'<1'

if foldclosedend(1) == line('$') || line("$") < 6
  " Don't fold if only one folded group or less than 6 results
  setlocal foldlevel=1
else
  setlocal foldlevel=0
endif

setlocal nowrap
