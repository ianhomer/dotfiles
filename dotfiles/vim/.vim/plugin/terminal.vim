"
" *** Scope : Terminal ***
"

function! OpenTerminal()
  let $VIM_DIR=expand('%:p:h')
  split
  term
  resize 10
  startinsert
endfunction

nnoremap <silent> <leader>a :call OpenTerminal()<CR>

tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
