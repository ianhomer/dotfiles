"
" Clean vi window
"

" Thanks https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one
" This is better than the `%bd | e#` technique since it doesn't close the
" current buffer at all. Closing the buffer and reopening file can trigger other
" plugins that cause a slight delay
function! s:CloseAllBuffersButCurrent()
  let l:gitBuffer = bufnr(".git/index")
  if l:gitBuffer > 0 | execute l:gitBuffer 'gq' | endif

  let current = bufnr("%")
  let buffers = filter(range(1, bufnr('$')), 'bufloaded(v:val)')
  let first = buffers[0]
  let last = buffers[-1]

  if current > first | execute first.",".(current-1)."bd" | endif
  if current < last  | execute (current+1).",".last."bd"  | endif
endfunction

function! s:SwitchToFirstTextFile()
  let l:current = bufnr("%")

  if <SID>IsEditableFile(current)
    " Current buffer is good for one to stay open
    return l:current
  endif

  " Find a more appropriate buffer to switch to
  for l:buffer in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    if <SID>IsEditableFile(l:buffer)
      echo l:buffer
      let l:window = bufwinnr(bufname(l:buffer))
      if l:window > 0
        execute l:window 'wincmd w'
      else
        execute ":buffer ".l:buffer
      endif
      return l:buffer
    endif
  endfor

  " Can't find a suitable buffer to switch to, so carry on with current as best
  " option.
endfunction

function! s:IsEditableFile(buffer)
  " Nonexistant buffer
  if bufexists(a:buffer) == 0 | return 0 | endif
  " Unmodifiable buffer
  if getbufvar(a:buffer, "&modifiable") == 0 | return 0 | endif
  " Fugitive
  if getbufvar(a:buffer, "&filetype") == "fugitive" | return 0 | endif
  " Buffer without a name
  if bufname(a:buffer) == "" | return 0 | endif
  " ... otherwise looks good for primary file to leave open
  return 1
endfunction

function! CloseOtherBuffers()
  wall
  let l:buffer = <SID>SwitchToFirstTextFile()
  " Mark current cursor position
  normal mA:
  NERDTreeClose
  :call <SID>CloseAllBuffersButCurrent()
  NERDTreeFind
  " Reset size of NERDTree
  normal 31<C-W>
  " Switch to last buffer
  wincmd p
  " Return to saved mark
  normal `A
endfunction

nnoremap <leader>o :call CloseOtherBuffers()<CR>
