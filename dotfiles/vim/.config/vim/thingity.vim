function! s:LintTable()
  echo "Linting markdown table"
  Tabularize/|/l1
endfunction

augroup thingity
  autocmd!
  " Lint table
  autocmd FileType markdown 
    \ nnoremap <buffer> <silent> <leader>t :call <SID>LintTable()<CR>
  " Auto lint when typing | in insert mode
  autocmd FileType markdown
    \ inoremap <buffer> <silent> <Bar> <Bar><Esc>:call <SID>LintTable()<CR>$a
  " Add table header (TODO - try to do this as part of the LintTable function if necessary)
  autocmd FileType markdown
    \ nnoremap <buffer> <silent> <leader>y {j0i\|\|\|<CR>\|--\|--\|<CR><ESC>:call <SID>LintTable()<CR>
  " definition block to 2 column table row (TODO - toggle back and forth)
  autocmd FileType markdown
    \ nnoremap <buffer> <silent> <leader>u {ddi\|<ESC>J/:<CR>:noh<CR>r\|<ESC>:call <SID>LintTable()<CR> 
augroup end
