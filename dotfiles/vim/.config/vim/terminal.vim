"
" *** Scope : Terminal ***
"

function! OpenTerminal()
  split
  term
  resize 10
  startinsert
endfunction

nnoremap <silent> <leader>t :call OpenTerminal()<CR>

tnoremap <Esc> <C-\><C-n>
