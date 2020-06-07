let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeIgnore = [ '^node_modules$' ]

function! NERDTreeFindOrToggle()
  if g:NERDTree.IsOpen() || @% == ""
    NERDTreeToggle
  else
    NERDTreeFind
  endif
endfunction

nnoremap <silent> <leader>n :call NERDTreeFindOrToggle()<CR>

