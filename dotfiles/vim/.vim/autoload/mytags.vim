function! mytags#Update()
  echo "Updating ctags : ".g:mytags_file
  call system("cd ".g:mytags_root.";ctags -R -f ".g:mytags_file."&")
endfunction
