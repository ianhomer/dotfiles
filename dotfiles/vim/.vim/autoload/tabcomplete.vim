function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! tabcomplete#auto_complete()
  if knobs#("coc")
    " Hand control to CoC
    return <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  endif
  " If at start of line or whitespace before character then we'll return a tab
  " character.
  let line = getline('.')
  let substr = strpart(line, -1, col('.'))
  let substr = matchstr(substr, "[^ \t]*$")
  if (strlen(substr)==0)
    return "\<TAB>"
  endif

  " Otherwise we're into auto completion.

  let has_period = match(substr, '\.') != -1
  " If substring has forward slash, but not preceded by a < (i.e. an XML close
  " element, then we'll treat this a path
  let is_path = match(substr, '\(<\)\@<!\/') != -1
  if (!has_period && !is_path)
    return "\<C-X>\<C-P>"
  elseif ( is_path )
    " Use CompletePath from dotfiles fzf.vim
    return fzf#CompletePath()
  else
    " Otherwise we hand to default insert completion.
    return "\<C-N>"
  endif
endfunction


