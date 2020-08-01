function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:auto_complete()
  if IsEnabled("coc")
    " Hand control to CoC
    return <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  endif
  let line = getline('.')
  let substr = strpart(line, -1, col('.'))
  let substr = matchstr(substr, "[^ \t]*$")
  if (strlen(substr)==0)
    return "\<TAB>"
  endif
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
    return "\<C-X>\<C-O>"
  endif
endfunction

" Map tab to auto complete
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>auto_complete()
