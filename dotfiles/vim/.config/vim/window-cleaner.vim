"
" Clean vi window
"

" Thanks https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one
" This is better than the `%bd | e#` technique since it doesn't close the
" current buffer at all. Closing the buffer and reopening file can trigger other
" plugins that cause a slight delay
function! CloseAllBuffersButCurrent()
  let curr = bufnr("%")
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')
  let first = buffers[0]
  let last = buffers[-1]

  if curr > first | execute first.",".(curr-1)."bd" | endif
  if curr < last  | execute (curr+1).",".last."bd"  | endif
endfunction

" Close all buffers except the current one and reopen default sized NERDTree
nnoremap <silent> <leader>o mA:NERDTreeClose<bar>wall<bar>:call CloseAllBuffersButCurrent()<bar>:NERDTreeFind<CR>31<C-W><bar>:wincmd p<CR>`A




