function! mytags#Update()
  call system("cd ".g:mytags_root.";ctags -R -f ".g:mytags_file)
endfunction
