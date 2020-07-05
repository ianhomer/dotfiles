function! DisabledEcho(command)
  echo a:command . " disabled - enable with space-1"
endfunction

" 1 = vanilla mode
function! ResetMode()
  set nonu
  set nornu
  set backspace=indent,eol,start
  set nohlsearch

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
function! PersonalDevMode()
  call ResetMode()
  set rnu
  set nu
endfunction

" 3 = mobbing mode
function! MobbingMode()
  call ResetMode()
  set nu
endfunction

" 4 = vi training mode
function! TrainingMode()
  call ResetMode()
  set rnu
  set backspace=0

  noremap <Up> :call DisabledEcho("normal mode up")<CR>
  noremap <Down> :call DisabledEcho("normal mode down")<CR>
  noremap <Left> :call DisabledEcho("normal mode left")<CR>
  noremap <Right> :call DisabledEcho("normal mode right")<CR>

  inoremap <Up> <ESC>:call DisabledEcho("insert mode up")<CR>
  inoremap <Down> <ESC>:call DisabledEcho("insert mode down")<CR>
  inoremap <Left> <ESC>:call DisabledEcho("insert mode left")<CR>
  inoremap <Right> <ESC>:call DisabledEcho("insert mode right")<CR>

  vnoremap <Up> :call DisabledEcho("visual mode up")<CR>
  vnoremap <Down> :call DisabledEcho("visual mode down")<CR>
  vnoremap <Left> :call DisabledEcho("visual mode left")<CR>
  vnoremap <Right> :call DisabledEcho("visual mode right")<CR>
endfunction

" Numbered modes of configuration
nnoremap <silent> <leader>1 :call ResetMode()<CR>
nnoremap <silent> <leader>2 :call PersonalDevMode()<CR>
nnoremap <silent> <leader>3 :call MobbingMode()<CR>
nnoremap <silent> <leader>4 :call TrainingMode()<CR>


