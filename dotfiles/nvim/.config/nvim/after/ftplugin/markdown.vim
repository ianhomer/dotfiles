" Support definition list as a list when formating
set formatlistpat+=\\\|^:\\s
" Support table row as list when formating
set formatlistpat+=\\\|^\|\\s

" Convert bold to backtick
nmap <silent> <leader>.c ds*cs*`

" Convert defintion list to table
nmap <silent> <leader>.r ds*cs*`Jf:r\|I\|\|<ESC>

