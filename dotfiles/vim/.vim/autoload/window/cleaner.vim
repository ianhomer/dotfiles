"
"
" Clean vi windows so that we are left with one buffer open and NERDTree
" focussed onto location of that file. The buffer we are left with is either the
" current buffer if it's a modifiable file, otherwise we find the first buffer
" that is.
"
" The cleaning process also closes down fugitive and FZF windows, to allow you
" to focus on the next thing you want to do.
"
" Thanks to
" https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one
" for starting me down this route.  Originally I was using the `%bd | e#`
" technique, but this
" was performing badly for me - I had to move to the right window first, there'd
" be an annoying (but small delay)
" since it'd open and close the buffer and I'd loose my cursor position.
" Some non-modifiable windows weren't closed either e.g. help windows.
"

if exists('g:window_cleaner_autoloaded')
  finish
endif
let g:window_cleaner_autoloaded = 1

function window#cleaner#Close(type)
  let l:window = bufwinnr(bufnr(a:type))
  if l:window > 0
    execute l:window 'q'
    return 1
  endif
  return 0
endfunction

function window#cleaner#CloseFugitive()
  return window#cleaner#Close(".git/index")
endfunction

function window#cleaner#CloseAllBuffersButCurrent()
  call window#cleaner#Close("fzf")

  let current = bufnr("%")
  let buffers = filter(range(1, bufnr('$')), 'bufloaded(v:val)')
  let first = buffers[0]
  let last = buffers[-1]

  if current > first | silent! execute first.",".(current-1)."bd" | endif
  if current < last  | silent! execute (current+1).",".last."bd"  | endif
endfunction

function window#cleaner#CloseOtherBuffers()
  wall
  let l:buffer = window#SwitchToFirstEditableFile()
  " Mark current cursor position
  normal mA:
  if exists('*NERDTreeClose')
    NERDTreeClose
  endif
  call window#cleaner#CloseAllBuffersButCurrent()
  call window#NERDTreeFindIfRoom()
  " Return to saved mark
  normal `A
endfunction

"
" Close current window
"
function window#cleaner#CloseMe()

  " Close fugitive if open
  if window#cleaner#CloseFugitive()
    call window#SwitchToFirstEditableFile()
    return
  endif

  if &filetype == "startify"
    " On startify window
    "   => close vi
    quit
  elseif len(getbufinfo({'buflisted':1})) > 1
        \ || (&filetype == "nerdtree" && len(getbufinfo({'buflisted':1})) == 1)
    " More than one buffer open or on nerdtree and one buffer open
    "   => close buffer and switch to next
    execute ":bd"
    call window#SwitchToFirstEditableFile()
  elseif &filetype == "nerdtree"
    if exists(':Startify') && winnr('$') == 1
      " Last window and Startify available
      "   => Open startify before closing NERDTree
      execute ":Startify"
    endif
    NERDTreeClose
  elseif exists("g:NERDTree") && g:NERDTree.IsOpen()
    " NERDTree open
    "   => close buffer and leave NERDTree open
    execute ":q"
  elseif exists(':Startify')
    execute ":bd"
    execute ":Startify"
  elseif bufname("%") == ""
    execute ":q"
  else
    execute ":bd"
  endif
endfunction
