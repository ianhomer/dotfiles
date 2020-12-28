" Map tab to auto complete

"if knobs#("lsp") 
"  imap <tab> <Plug>(completion_smart_tab)
"  imap <s-tab> <Plug>(completion_smart_s_tab)
"else
  " Use <Tab> and <S-Tab> to navigate through popup menu
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : tabcomplete#auto_complete()
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"endif
