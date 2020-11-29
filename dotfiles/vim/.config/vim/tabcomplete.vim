" Map tab to auto complete
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ tabcomplete#auto_complete()
