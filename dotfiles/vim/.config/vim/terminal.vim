"
" *** Scope : Terminal ***
"

function! OpenTerminal()
  split
  term
  resize 10
endfunction
nnoremap <silent> <leader>t :call OpenTerminal()<CR>
" Map escape in terminal mode to enter normal mode
tnoremap <Esc> <C-\><C-n>
