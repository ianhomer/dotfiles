if g:config_level < 2
  finish
endif

function! s:LintTable()
  let l:line = line('.')

  " Skip if not a table
  if getline(l:line) !~ '|'
    return
  endif

  " Add heading to table if not already there
  " First check if next line is the header marker (in case we're on the
  " first line of the table
  let l:foundTableHeader = getline(l:line+1) =~ '--'
  " Then scan back for the header marker
  while l:line > -1
    if getline(l:line) !~ '[^\s]' | break | endif
    if getline(l:line) =~ '--'
      let l:foundTableHeader = 1
      break
    endif
    let l:line -=1
  endwhile
  if !l:foundTableHeader
    call s:AddTableHeader()
  endif
  echo "Linting markdown table"
  Tabularize/|/l1
endfunction

function! s:AddTableHeader()
  execute "normal! {j0i\|\|\|\<CR>\|--\|--\|\<CR>\<ESC>"
endfunction

" Auto insert of next line
function! s:NextLine()
  let l:previousLineNumber = line(".") - 1
  let l:previous = getline(l:previousLineNumber)
  " Continuation of bullet list
  if l:previous =~ '-\s'
    " Continuation of todo list
    if l:previous =~ '\v-\s\[.+\]\s'
      if l:previous =~ '\v-\s\[.+\]\s\w+'
        return "- [ ] "
      else
        " Previous item was enter so clear and stop list
        call setline(l:previousLineNumber,'')
      endif
    else
      if l:previous =~ '\v-\s\w+'
        return "- "
      else
        " Previous item was enter so clear and stop list
        call setline(l:previousLineNumber,'')
      endif
    endif
  elseif l:previous =~ '|'
    if l:previous =~ '\v\|\s\w+'
      return '| '
    else 
      call setline(l:previousLineNumber,'')
    endif
  endif
  return ""
endfunction

nnoremap <buffer> <silent> <leader>jr :call <SID>LintTable()<CR>
" Auto lint when typing | in insert mode
inoremap <buffer> <silent> <Bar> <Bar><Esc>:call <SID>LintTable()<CR>$a
" Auto continuation on carriage return
inoremap <buffer> <CR> <CR><C-R>=<SID>NextLine()<C-M>

" The rest of this filetype plugin is not relevant if we're using CoC
if IsEnabled("coc")
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

set comments=fb:*,fb:-,fb:+,fb:\:,nb:>,se:---,se:```

" Markdown surrounds
" bold
nmap <buffer> <leader>jb ysiWb
" italic
nmap <buffer> <leader>ji ysiW*
" link
nmap <buffer> <leader>jl EBysiW(i[]<C-o>h
" bare link
nmap <buffer> <leader>jL ysiW<

" Convert bold to backtick, move to next row
nmap <buffer> <silent> <leader>jc 0f*ds*cs*`j

" Convert defintion list to table, move to next definition
nmap <buffer> <silent> <leader>jr 0ds*cs*`Jf:r\|I\|\|<ESC>jj

setlocal spell

" A local spell file for the current file should be located in a .vim directory
" in one of the parent directories.
function! AddLocalSpellFile(directory, depth)
  if a:depth < 10 && a:directory != "/"
    let l:localvimdir = a:directory . "/.vim"
    if isdirectory(l:localvimdir)
      " Add all *.add files found in parent .vim directory to local spellfile
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
