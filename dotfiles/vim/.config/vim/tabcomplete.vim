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
  let has_slash = match(substr, '\/') != -1
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"
  elseif ( has_slash )
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
