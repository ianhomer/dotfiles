if get(g:, "knobs_level", 0) < 3
  finish
endif
""
" Lightweight ctags loader since gutentags heavy weight and I've seen excessive
" calls by it for regeneration of ctags
" Only setup when in git repo
" Run on start up if file does not exist
" To refresh ctags run :MyTags
"
let g:mytags_root = finddir('.git/..', ';')
if g:mytags_root != ""
  let g:mytags_file = expand("~/.cache/tags/".substitute(g:mytags_root[1:], '[/\.]', '-', 'g')."-tags")
  let &tags = g:mytags_file
  set notagrelative

  if !filereadable(g:mytags_file)
    call mytags#Update()
  endif

  command! -nargs=0 MyTags :call mytags#Update()
endif
