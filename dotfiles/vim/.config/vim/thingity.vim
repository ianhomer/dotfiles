function! s:AlignTable()
  echo "Aligning table"
  Tabularize /|/l1
endfunction

if exists(":Tabularize")
  nnoremap <silent> <leader>t :call <SID>AlignTable()<CR>
  "inoremap <silent> <Bar> <Bar><Esc>:call <SID>AlignTable()<CR>/|<CR>a
else
  nnoremap <silent> <leader>t :echo "Tabular not installed"<CR>
endif
