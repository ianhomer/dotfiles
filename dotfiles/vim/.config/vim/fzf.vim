" Custimise fzf behaviour.
"

let $FZF_DEFAULT_COMMAND = 'fd -H --type f'

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

nnoremap <silent> <leader>,i :call fzf#vim#files('~/projects/things', {'source':'fd -L .md'})<CR>

inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \ fzf#wrap({
    \   'dir': expand('%:p:h'),
    \   'window': { 'width': 0.4, 'height': 0.3},
    \ }))

" exact
nnoremap <silent> <leader>jj :Ag<CR>'
nnoremap <silent> <leader>jJ :Ag!<CR>'
" todos
nnoremap <silent> <leader>jt :Ag<CR>'[\ ]
nnoremap <silent> <leader>jT :Ag!<CR>'[\ ]

" Make Ag match on just content, not including file path
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, {
  \   'window': { 'width': 0.9, 'height': 0.9},
  \   'options': '--delimiter : --nth 4..'
  \ }, 
  \ <bang>0)

" hidden
command! -bar -bang AgHidden
  \ call fzf#vim#ag(<q-args>,'-m 0 --hidden --ignore .git', <bang>0)
nnoremap <silent> <leader>jh :AgHidden<CR>

nnoremap <silent> <leader>m :Maps<CR>
nnoremap <silent> <leader>M :Maps!<CR>
nnoremap <silent> <leader>,mi :MapsInsert<CR>
