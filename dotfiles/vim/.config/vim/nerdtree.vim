function! NERDTreeFindOrToggle()
  if g:NERDTree.IsOpen() || @% == ""
    NERDTreeToggle
  else
    NERDTreeFind
  endif
endfunction

