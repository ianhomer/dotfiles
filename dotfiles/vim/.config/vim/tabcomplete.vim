" Map tab to auto complete

if knobs#("lsp")
  " Use <Tab> and <S-Tab> to navigate through popup menu
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
else
  " Before neovim 0.5
  inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ tabcomplete#auto_complete()
endif
