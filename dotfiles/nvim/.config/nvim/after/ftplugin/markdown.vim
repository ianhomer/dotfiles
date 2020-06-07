if g:config_level < 2
  finish
endif

function! s:LintTable()
  echo "Linting markdown table"
  Tabularize/|/l1
endfunction

nnoremap <buffer> <silent> <leader>t :call <SID>LintTable()<CR>
" Auto lint when typing | in insert mode
inoremap <buffer> <silent> <Bar> <Bar><Esc>:call <SID>LintTable()<CR>$a
" Add table header (TODO - try to do this as part of the LintTable function if necessary)
nnoremap <buffer> <silent> <leader>y {j0i\|\|\|<CR>\|--\|--\|<CR><ESC>:call <SID>LintTable()<CR>

" The rest of this filetype plugin is not relevant if we're using CoC
if g:coc_enabled == 1
  finish
end

" Support definition list as a list when formating
set formatlistpat+=\\\|^:\\s
" Support table row as list when formating
set formatlistpat+=\\\|^\|\\s
" Support fenced blocks
set formatlistpat+=\\\|^\\s\\{4\\}
" Support frontmatter yaml
set formatlistpat+=\\\|^[^:\\s]\\+:\\s

set autoindent

set formatoptions=jtcqln

set comments=fb:*,fb:-,fb:+,n:>,se:---,se:```

" Markdown surrounds
" bold
nmap <buffer> <leader>kb ysiWb
" italic
nmap <buffer> <leader>ki ysiW*
" link
nmap <buffer> <leader>kl EBysiW(i[]<C-o>h
" bare link
nmap <buffer> <leader>kL ysiW<

" Convert bold to backtick, move to next row
nmap <buffer> <silent> <leader>kc 0f*ds*cs*`j

" Convert defintion list to table, move to next definition
nmap <buffer> <silent> <leader>kr 0ds*cs*`Jf:r\|I\|\|<ESC>jj

setlocal spell

" Find local spell file
function! AddLocalSpellFile(directory, depth)
  if a:depth < 10 && a:directory != "/"
    let l:localvimdir = a:directory . "/.vim"
    if isdirectory(l:localvimdir)
      " Add all *.add files found in parent .vim directory to to local spellfile
      for l:localspellfile in split(glob(l:localvimdir . "/*.add"))
        if &l:spellfile !~ l:localspellfile
          let &l:spellfile = l:localspellfile . "," . &l:spellfile
        endif
      endfor
    endif
    call AddLocalSpellFile(fnamemodify(a:directory, ":h"), a:depth + 1)
  endif
endfunction

call AddLocalSpellFile(expand('%:p:h'), 0)



