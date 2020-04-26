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


