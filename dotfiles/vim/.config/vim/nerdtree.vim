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

" https://github.com/preservim/nerdtree/wiki
" If more than one window and previous buffer was NERDTree, go back to it.
" autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
