" Support definition list as a list when formating
set formatlistpat+=\\\|^:\\s
" Support table row as list when formating
set formatlistpat+=\\\|^\|\\s

" Markdown surrounds
" bold
nmap <leader>kb ysiWb
" italic
nmap <leader>ki ysiW*
" link
nmap <leader>kl EBysiW(i[]<C-o>h
" bare link
nmap <leader>kL ysiW<

" Convert bold to backtick, move to next row
nmap <silent> <leader>kc 0f*ds*cs*`j

" Convert defintion list to table, move to next definition
nmap <silent> <leader>kr 0f*ds*cs*`Jf:r\|I\|\|<ESC>jj

