function! s:LintTable()
  echo "Linting markdown table"
  Tabularize/|/l1
endfunction

augroup thingity
  autocmd!
  if exists('g:tabular_loaded') && g:tabular_loaded == 1
    " Lint table
    autocmd FileType markdown 
      \ nnoremap <buffer> <silent> <leader>t :call <SID>LintTable()<CR>
    " Auto lint when typing | in insert mode
    autocmd FileType markdown
      \ inoremap <buffer> <silent> <Bar> <Bar><Esc>:call <SID>LintTable()<CR>$a
    " Add table header (TODO - try to do this as part of the LintTable function if necessary)
    autocmd FileType markdown
      \ nnoremap <buffer> <silent> <leader>y {j0i\|x\|y<CR>\|--\|--<CR><ESC>:call <SID>LintTable()<CR>
  else
    nnoremap <silent> <leader>t :echo "Tabular not installed"<CR>
  endif
augroup end
