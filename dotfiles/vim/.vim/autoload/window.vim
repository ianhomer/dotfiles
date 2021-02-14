if exists('g:window_autoloaded')
  finish
endif
let g:window_autoloaded = 1

" Open NERDTree if there is space for it
function window#NERDTreeFindIfRoom()
  if winwidth('%') > 112
    let l:current = window#Mark()
    NERDTreeFind
    " Reset size of NERDTree
    normal 31<C-W>
    call window#SwitchToMark(l:current)
  endif
endfunction

function window#Mark()
  normal mA:
  return bufnr("%")
endfunction

function window#SwitchToMark(current)
  " Switch back to last buffer, i.e. the one we want open
  let l:window = bufwinnr(a:current)
  if l:window > 0
    execute l:window 'wincmd w'
  endif
  normal `A
endfunction

function window#SwitchToFirstEditableFile()
  let l:current = bufnr("%")

  if <SID>IsEditableFile(current) || winnr('$') == 1 
    " Current buffer is good for one to stay open
    return l:current
  endif

  " Find a more appropriate buffer to switch to
  for l:buffer in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    " Is buffer in active window and editable?
    if bufwinnr(l:buffer) > -1 && <SID>IsEditableFile(l:buffer)
      let l:window = bufwinnr(l:buffer)
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

function s:IsEditableFile(buffer)
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

function window#ToggleFugitive()
  if !window#cleaner#CloseFugitive()
    Gstatus
  endif
endfunction

