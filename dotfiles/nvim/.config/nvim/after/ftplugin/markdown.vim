function! s:LintTable()
  echo "Linting markdown table"
  Tabularize/|/l1
endfunction

nnoremap <buffer> <silent> <leader>t :call <SID>LintTable()<CR>
" Auto lint when typing | in insert mode
inoremap <buffer> <silent> <Bar> <Bar><Esc>:call <SID>LintTable()<CR>$a
" Add table header (TODO - try to do this as part of the LintTable function if necessary)
nnoremap <buffer> <silent> <leader>y {j0i\|\|\|<CR>\|--\|--\|<CR><ESC>:call <SID>LintTable()<CR>

" Support definition list as a list when formating
set formatlistpat+=\\\|^:\\s
" Support table row as list when formating
set formatlistpat+=\\\|^\|\\s

" Markdown surrounds
" bold
nmap <buffer> <leader>kb ysiWb
" italic
nmap <buffer> <leader>ki ysiW*
" link
nmap <buffer> <leader>kl EBysiW(i[]<C-o>h
" bare link
nmap <buffer> <leader>kL ysiW<

" Convert bold to backtick, move to next row
nmap <buffer> <silent> <leader>kc 0f*ds*cs*`j

" Convert defintion list to table, move to next definition
nmap <buffer> <silent> <leader>kr 0ds*cs*`Jf:r\|I\|\|<ESC>jj

set spell

" Find local spell file
function! AddLocalSpellFile(directory, depth)
  if a:depth < 10 && a:directory != "/"
    let l:localspellfile = a:directory . "/.vim/local.utf-8.add"
    if filereadable(l:localspellfile) && &spellfile !~ l:localspellfile 
      let &spellfile = l:localspellfile . "," . &spellfile
    endif
    call AddLocalSpellFile(fnamemodify(a:directory, ":h"), a:depth + 1)
  endif
endfunction

call AddLocalSpellFile(expand('%:p:h'), 0)



