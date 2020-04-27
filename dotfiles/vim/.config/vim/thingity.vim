function! s:LintTable()
  echo "Linting markdown table"
  Tabularize/|/l1
endfunction

augroup thingity
  autocmd!
  if exists('g:tabular_loaded') && g:tabular_loaded == 1
    autocmd FileType markdown 
      \ nnoremap <buffer> <silent> <leader>t :call <SID>LintTable()<CR>
    autocmd FileType markdown
      \ inoremap <buffer> <silent> <Bar> <Bar><Esc>:call <SID>LintTable()<CR>$a
    "autocmd FileType markdown
    "  \ nnoremap <buffer> <silent> <leader>y Oi|x|y|<CR>|--|--|<CR><ESC>:call <SID>LintTable()<CR>
  else
    nnoremap <silent> <leader>t :echo "Tabular not installed"<CR>
  endif
augroup end
