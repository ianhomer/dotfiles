if !knobs#("fzf")
  finish
endif

" Custimise fzf behaviour.
"

let $FZF_DEFAULT_COMMAND = 'fd -H --type f'
" Preview hidden by default
let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-/']

" tiebreak on index for Maps so that the natural sort order of the source
" (i.e. alphabetical on string from vim maps command takes precedence as
" opposed to sorting on length of string). This alphabetical order is more
" natural since we're normally looking for what has been configured. In
" particular searching for "space" makes it easy to see what has been
" configured for the leader.
command! -bar -bang Maps
  \ call fzf#vim#maps("n", {'options': '--tiebreak=index'}, <bang>0)

command! -bar -bang MapsInsert
  \ call fzf#vim#maps("i", {'options': '--tiebreak=index'}, <bang>0)

let s:pop_rows = 10
let s:pop_cols = 40

function! fzf#GetHeight()
  return 1.0 * s:pop_rows / &lines
endfunction

function! fzf#GetWidth()
  return 1.0 * s:pop_cols / &columns
endfunction

function! fzf#GetY()
  return 1.0 * (screenrow() + 1 + s:pop_rows/2 ) / &lines
endfunction

function! fzf#GetX()
  return 1.0 * screencol() / &columns
endfunction

function! fzf#CompletePath() 
  return fzf#vim#complete#path(
    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \ fzf#wrap({
    \   'dir': expand('%:p:h'),
    \   'window': { 
    \     'width': fzf#GetWidth(), 'height': fzf#GetHeight(), 
    \     'xoffset': fzf#GetX(), 'yoffset': fzf#GetY()
    \    },
    \ }))
endfunction

command! -nargs=* -bang CompletePath call fzf#CompletePath()

inoremap <expr> <c-x><c-f> fzf#CompletePath()

function! fzf#SearchWithRipGrep(query, fullscreen)
  let command_fmt = 
        \ 'rg --column --line-number --no-heading --color=always --smart-case -m 1 -- %s'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 
        \ 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Search call fzf#SearchWithRipGrep(<q-args>, <bang>0)

nnoremap <silent> <leader>s :AgWithOutFileName!<CR>
nnoremap <silent> <leader>S :Ag!<CR>
nnoremap <silent> <leader>jk :Ag<CR>'
nnoremap <silent> <leader>jK :Ag!<CR>'

" Make Ag match on just content of file and not search on the 
" not including file path name
command! -bang -nargs=* AgWithOutFileName
  \ call fzf#vim#ag(<q-args>, 
  \  '--hidden -p ~/.dotfiles/config/ag/.ignore', {
  \   'options': '--delimiter : --nth 4..'
  \ }, 
  \ <bang>0)

command! -bang -nargs=* AgPopup
  \ call fzf#vim#ag(<q-args>, 
  \  '-p ~/.dotfiles/config/ag/.ignore', {
  \   'window': { 'width': 0.9, 'height': 0.9},
  \   'options': '--delimiter : --nth 4..'
  \ }, 
  \ <bang>0)

nnoremap <silent> <leader>,m :Maps<CR>
nnoremap <silent> <leader>,M :Maps!<CR>
nnoremap <silent> <leader>,mi :MapsInsert<CR>
