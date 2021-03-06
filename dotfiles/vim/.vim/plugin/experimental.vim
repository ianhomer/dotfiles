if !KnobAt(9)
  finish
endif

" *** Scope : Experimental ***
"

" Placeholder for experimental output
function! ShowDebug()
  echo "col=".string(getpos('.')[2]).";pos="
    \ .string(getpos('.')).";line-length=".strlen(getline("."))
endfunction
nnoremap <silent> <leader>] :call ShowDebug()<CR>

