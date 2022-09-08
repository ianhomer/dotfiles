if exists('g:modes_autoloaded')
  finish
endif
let g:modes_autoloaded = 1

function modes#DisabledEcho(command)
  echo a:command . " disabled - enable with space-1"
endfunction

" 1 = vanilla mode
function modes#ResetMode()
  set showtabline=0
  BarbarDisable
  " not sure why, but commands below cause Trouble to error, so let's just close
  " when we rest
  TroubleClose
  bufdo windo if &modifiable | set nonu | endif
  bufdo windo if &modifiable | set nornu | endif
  set backspace=indent,eol,start
  set nohlsearch
  set laststatus=3
  lua require"lualine".setup({options={globalstatus=true}})

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

" 2 = personal dev mode
function modes#PersonalDevMode()
  call modes#ResetMode()
  bufdo windo if &modifable | set rnu | endif
  bufdo windo if &modifiable | set nu | endif
  set laststatus=3
  lua require"lualine".setup({options={globalstatus=true}})
endfunction

" 3 = mobbing mode
function modes#MobbingMode()
  BarbarEnable
  set showtabline=2
  set laststatus=2
  bufdo windo if &modifiable | set nu | endif
  lua require"lualine".setup({options={globalstatus=false}})
endfunction

" 4 = vi training mode
function modes#TrainingMode()
  call modes#ResetMode()
  set rnu
  set backspace=0

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

