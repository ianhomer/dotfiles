let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeIgnore = [ '^node_modules$' ]
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 0
let NERDTreeAutoDeleteBuffer = 1

let NERDTreeDirArrowExpandable=""
let NERDTreeDirArrowCollapsible=""
" Don't shrink menu
let NERDTreeMinimalMenu = 0

function! NERDTreeFindOrToggle()
  if g:NERDTree.IsOpen() || @% == ""
    if winnr('$') > 1 || &filetype == "startify" 
      NERDTreeToggle
    else
      " NERDTree doesn't like closing itself if it's the last window, so we'll
      " use the CloseMe function which will drop back to Startify
      call CloseMe()
    endif
  else
    NERDTreeFind
  endif
endfunction

nnoremap <silent> <leader>n :call NERDTreeFindOrToggle()<CR>

" https://github.com/preservim/nerdtree/wiki
" If more than one window and previous buffer was NERDTree, go back to it.
" autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
