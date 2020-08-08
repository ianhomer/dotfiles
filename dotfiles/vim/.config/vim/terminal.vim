"
" *** Scope : Terminal ***
"

function! OpenTerminal()
  split
  term
  resize 10
  startinsert
endfunction

nnoremap <silent> <leader> :call OpenTerminal()<CR>

tnoremap <Esc> <C-\><C-n>
