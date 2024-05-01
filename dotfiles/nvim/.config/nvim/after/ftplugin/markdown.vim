if !knobs#At(2)
  finish
endif

function! s:LintTodo()
  let l:line = line('.')

  if getline(l:line) =~ '^-\s*[\s*$'
    call setline(l:line,'- [ ] ')
  endif
endfunction

function! s:LintTable()
  let l:line = line('.')
  let l:lineValue = getline(l:line)

  " Skip if not a table
  if len(l:lineValue) > 0 && l:lineValue[0] != '|'
    return
  endif

  " Skip if starts with 4 spaces, i.e. a code block
  if l:lineValue =~ '^\s\s\s\s'
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
  echo l:previous
  " Continuation of bullet list
  if l:previous =~ '\v^\s*-\s'
    " Continuation of todo list
    if l:previous =~ '\v^\s*-\s\[.\]\s'
      if l:previous =~ '\v^\s*-\s\[.\]\s*$'
        " Previous item was empty todo so clear and stop list
        normal k"_ddj
      else
        return "- [ ] "
      endif
    else
      if l:previous =~ '\v^\s*-\s*$'
        " Previous item was enter so clear and stop list
        normal k"_ddj
      else
        return "- "
      endif
    endif
  elseif l:previous =~ '\v^\>\s'
    if l:previous =~ '\v^\>\s*$'
      normal k"_ddj
    else
      return "> "
    endif
  elseif l:previous =~ '\v^[0-9]+\.'
    " Numbered list
    if l:previous =~ '\v^[0-9]+\.\s*$'
      normal k"_ddj
    else
      let value=matchstr(l:previous, '\v^\zs[0-9]+\ze\.')
      return (value + 1).'. '
    endif
  elseif l:previous =~ '\v^\|'
    if l:previous =~ '\v^\|\s*$'
      normal k"_ddj
    else
      return '| '
    endif
  endif
  return ""
endfunction

function s:CarriageReturn()
  if getline(".") =~ '\v-\s\[\s\]\s\w+'
    s/\[\s\]/[x]/
    normal ``
  elseif getline(".") =~ '\v-\s\[x\]\s\w+'
    s/\[x\]/[ ]/
    normal ``
  else
    normal j
  endif
endfunction

nnoremap <buffer> <silent> <leader>jr :call <SID>LintTable()<CR>
" Auto lint when typing | in insert mode
inoremap <buffer> <silent> <Bar> <Bar><Esc>:call <SID>LintTable()<CR>$a
" Auto todo when typing - [ in insert mode
" Auto continuation on carriage return
inoremap <buffer> <silent> <CR> <CR><C-R>=<SID>NextLine()<C-M>

if knobs#("markdown_flow")
  nnoremap <buffer> <silent> <CR> :call <SID>CarriageReturn()<CR>
  inoremap <buffer> <silent> [ [<C-O>:call <SID>LintTodo()<CR><C-O>$
endif

" Support definition list as a list when formating
set formatlistpat+=\\\|^:\\s
" Support table row as list when formating
set formatlistpat+=\\\|^\|\\s
" Support fenced blocks
set formatlistpat+=\\\|^\\s\\{4\\}
let g:markdown_fenced_languages = [
  \ 'bash=sh',
  \ 'html',
  \ 'java',
  \ 'javascript',
  \ 'json',
  \ 'python',
  \ 'sh',
  \ 'typescript'
  \ ]
" Support frontmatter yaml
set formatlistpat+=\\\|^[^:\\s]\\+:\\s

set autoindent

set formatoptions=jtcqln

set comments=fb:*,fb:-,fb:+,fb:\:,nb:>,se:---,se:```

" conceallevel controls how text with the "conceal" syntax attribute is shown
if knobs#("markdown_conceal_full")
  " e.g. mobile
  set conceallevel=2
elseif knobs#("markdown_conceal_partial")
  " e.g. note taking
  set conceallevel=1
elseif knobs#("obsidian")
  " obsidian UI needs conceallevel=2
  set conceallevel=0
else
  " e.g coding
  set conceallevel=0
endi
set concealcursor=nc

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
      for l:relativespellfile in split(glob(l:localvimdir . "/*.add"))
        let l:spellfile=fnamemodify(l:relativespellfile, ":p")
        if &spellfile != ''
          exec 'set spellfile='.l:spellfile . "," . &spellfile
        else
          exec 'set spellfile='.l:spellfile
        endif
      endfor
    endif
    let parent = fnamemodify(a:directory, ":h")
    if parent != a:directory
      call AddLocalSpellFile(parent, a:depth + 1)
    endif
  endif
endfunction

let mypath = expand("%p:h")
try
  call AddLocalSpellFile(mypath, 0)
catch
  echo "*** Cannot add local spell file for ".mypath
endtry
