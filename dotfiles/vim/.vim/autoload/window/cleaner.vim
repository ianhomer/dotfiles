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
  if exists(':NvimTreeClose')
    " Close Nvim cleanly since using bd on NvimTree leads to a file named
    " NvimTree being created
    NvimTreeClose
  endif
  let current = bufnr("%")
  " Find the listed buffers
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')
  let first = buffers[0]
  let last = buffers[-1]

  for buffer in buffers
    " Close every buffer except the current
    if current != buffer
      execute buffer."bd"
    endif
  endfor
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
  if exists('*NERDTreeClose')
    call window#NERDTreeFindIfRoom()
  endif
  " Return to saved mark
  normal `A
endfunction

"
" Close current window
"
function window#cleaner#CloseMe()

  " If goyo enabled then force close goyo otherwise hanging windows
  " can remain
  if knobs#("goyo")
    execute ":Goyo!"
  endif

  " Close fugitive if open
  if window#cleaner#CloseFugitive()
    call window#SwitchToFirstEditableFile()
    return
  endif

  if &filetype == "startify" || (&buftype != "" && &filetype != "NvimTree")
    " Close startify window or non writable buffer
    quit
  elseif exists("#Zen")
    " Exit zen mode
    execute ":ZenMode"
  elseif len(getbufinfo({'buflisted':1})) > 1
        \ || ((&filetype == "nerdtree" || &filetype == "NvimTree")
        \ && len(getbufinfo({'buflisted':1})) == 1)
    " More than one buffer open or on nerdtree and one buffer open
    "   => close buffer and switch to next
    if &filetype == "NvimTree"
      NvimTreeClose
    else
      execute ":bd"
    endif
    call window#SwitchToFirstEditableFile()
  elseif &filetype == "nerdtree"
      \ || &filetype == "NvimTree"
    if knobs#("startify") && exists(':Startify') && winnr('$') == 1
      " Last window and Startify available
      "   => Open startify before closing NERDTree
      execute ":Startify"
    endif
    if &filetype == "nerdtree"
      NERDTreeClose
    else
      NvimTreeClose
    endif
  elseif exists("g:NERDTree") && g:NERDTree.IsOpen()
    " NERDTree open
    "   => close buffer and leave NERDTree open
    execute ":q"
  elseif knobs#("startify") && exists(':Startify')
    if exists('g:loaded_tree')
      NvimTreeClose
    endif
    execute ":bd"
    execute ":Startify"
  elseif @% == ""
    " No filename specified
    execute ":q"
  else
    execute ":wq"
  endif
endfunction
