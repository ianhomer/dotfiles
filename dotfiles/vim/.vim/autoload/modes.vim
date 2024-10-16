if exists('g:modes_autoloaded') || !exists("g:knob_modes")
  finish
endif
let g:modes_autoloaded = 1

function modes#DisabledEcho(command)
  echo a:command . " disabled - hit <space>-1 to enable"
endfunction

function modes#setLineNumbers(absolute, relative)
  if &modifiable
    if a:relative | set rnu | else | set nornu | endif
    if a:absolute | set nu | else | set nonu | endif
  endif
endfunction

function modes#enableBarbar(enable)
  if a:enable == 1
    if knobs#("barbar")
      BarbarEnable
      lua require"config.barbar".show()
    endif
    set showtabline=2
  else
    if knobs#("barbar")
      lua require"config.barbar".hide()
    endif
    set showtabline=0
  endif
endfunction

function modes#Reset()
  silent! nunmap <Up>
  silent! nunmap <Down>
  silent! nunmap <Left>
  silent! nunmap <Right>

  silent! iunmap <Up>
  silent! iunmap <Down>
  silent! iunmap <Left>
  silent! iunmap <Right>

  silent! vunmap <Up>
  silent! vunmap <Down>
  silent! vunmap <Left>
  silent! vunmap <Right>
endfunction

" 1 = vanilla mode
function modes#ResetMode()
  " not sure why, but commands below cause Trouble to error, so let's just close
  " when we rest
  Trouble diagnostics close
  call modes#enableBarbar(0)
  windo call modes#setLineNumbers(0, 0)
  bufdo call modes#setLineNumbers(0, 0)
  set backspace=indent,eol,start
  set nohlsearch
  set laststatus=3
  set conceallevel=1
  lua require"lualine".setup({options={globalstatus=true}})
  call modes#Reset()
endfunction

" 2 = personal dev mode
function modes#PersonalDevMode()
  call modes#ResetMode()
  windo call modes#setLineNumbers(0,1)
  set laststatus=3
  set conceallevel=1
  lua require"lualine".setup({options={globalstatus=true}})
  call modes#Reset()
endfunction

" 3 = mobbing mode
function modes#MobbingMode()
  call modes#enableBarbar(1)
  set laststatus=2
  set conceallevel=0
  windo call modes#setLineNumbers(1,0)
  lua require"lualine".setup({options={globalstatus=false}})
  call modes#Reset()
endfunction

" 4 = vi training mode
function modes#TrainingMode()
  call modes#ResetMode()
  set rnu

  noremap <Up> :call modes#DisabledEcho("normal mode up")<CR>
  noremap <Down> :call modes#DisabledEcho("normal mode down")<CR>
  noremap <Left> :call modes#DisabledEcho("normal mode left")<CR>
  noremap <Right> :call modes#DisabledEcho("normal mode right")<CR>

  inoremap <Up> <ESC>:call modes#DisabledEcho("insert mode up")<CR>
  inoremap <Down> <ESC>:call modes#DisabledEcho("insert mode down")<CR>
  inoremap <Left> <ESC>:call modes#DisabledEcho("insert mode left")<CR>
  inoremap <Right> <ESC>:call modes#DisabledEcho("insert mode right")<CR>

  vnoremap <Up> :call modes#DisabledEcho("visual mode up")<CR>
  vnoremap <Down> :call modes#DisabledEcho("visual mode down")<CR>
  vnoremap <Left> :call modes#DisabledEcho("visual mode left")<CR>
  vnoremap <Right> :call modes#DisabledEcho("visual mode right")<CR>
endfunction

