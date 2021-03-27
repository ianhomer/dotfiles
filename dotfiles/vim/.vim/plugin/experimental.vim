if !KnobAt(9)
  finish
endif

if knobs#could("conflict_marker")
  autocmd ColorScheme * highlight Info gui=bold guifg=#504945 guibg=#83a598
  let g:conflict_marker_highlight_group="Info"
endif

if knobs#could("syntastic")
  let g:vim_jsx_pretty_colorful_config = 1
endif

if knobs#could("nnn")
  let g:nnn#set_default_mappings = 0
  let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6  } }
  nnoremap <silent> <leader>m :NnnPicker<CR>
endif

" *** Scope : Experimental ***
"

" Placeholder for experimental output
function! ShowDebug()
  echo "col=".string(getpos('.')[2]).";pos="
    \ .string(getpos('.')).";line-length=".strlen(getline("."))
endfunction
nnoremap <silent> <leader>] :call ShowDebug()<CR>

