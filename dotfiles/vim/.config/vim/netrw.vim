"
" *** Scope : netrw ***
"
let g:netrw_liststyle = 3
let g:netrw_keepdir=0
" When netrw pane hides then close it
" Thanks - https://github.com/tpope/vim-vinegar/issues/13
autocmd FileType netrw setl bufhidden=wipe
let g:netrw_fastbrowse = 0


