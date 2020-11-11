function! LintMarkdown()
  normal ma
  let currentLine=line("'a")
  call PruneWhiteSpace()
  normal gg
  " Do not format fenced blocks. I can't find a way to configure the default vim
  " formatting to not join lines in fenced blocks, so instead we'll only format
  " up to the fenced block and then continue after. Note that a fenced block
  " must specify a language which is used to anchor this skipping.
  while search('```','n',line('$')) > 0
    silent execute "normal v/```[a-z]\\+\<CR>gq\<ESC>"
    silent execute "normal /```\<CR>j"
  endwhile
  normal gqG
  " Safely jump mark only it exists. If we don't do this then the mark jump will
  " error
  if currentLine == 0
    normal gg
  elseif line("'a") > 0
    normal `a
  endif
endfunction

" Insert time stamp - as markdown header
function! s:ThingityDateHeading()
  normal ma
  " Insert line before if previous line is not empty
  if getline(line('.') - 1) =~ '[^\s]'
    execute "normal mbO\<ESC>`b"
  endif

  execute "normal! I".thingity#GetThingityDateHeading()."\<CR>"
  " Insert line after if next line is not empty
  if getline('.') =~ '[^\s]'
    execute "normal mbO\<ESC>`b"
  endif

  normal `ajo
endfunction

function! s:ThingityTime()
  return strftime("%H:%M")
endfunction

"
" Get the root of the thing project.
"
function! s:ThingityGetRoot()
  " First try to find git root
  let l:root = fnameescape(
    \ fnamemodify(finddir('.git', escape(expand('%:p:h'), ' ').";"), ":h"))
  if isdirectory(l:root."/.git")
    return l:root
  endif

  " Then try to find the stream directory
  let l:root = fnameescape(
    \ fnamemodify(finddir('stream', escape(expand('%:p:h'), ' ').";"), ":h"))
  if isdirectory(l:root."/stream")
    return l:root
  endif

  "
  " Find default thing project, which is the first subdirectory that is a git
  " project or has a stream directory
  "
  let l:dirs = filter(globpath(getcwd(), '*', 0, 1),"isdirectory(v:val.'/.git') && isdirectory(v:val.'/stream')")
  if len(l:dirs) == 0
    return getcwd()
  elseif len(l:dirs) == 1
    return l:dirs[0]
  endif
  "
  " Otherwise find the last one used
  "
  let modifiedDate = 0
  let latestRoot = l:dirs[0]
  for dir in l:dirs
    if getftime(dir) > modifiedDate
      let modifiedDate = getftime(dir)
      let latestRoot = dir
    endif
  endfor
  return dir
endfunction

"
" Get the thing string root, i.e. stream directory if it exists or root otherwise.
function! s:ThingityGetStreamRoot()
  let l:root = s:ThingityGetRoot()
  if isdirectory(l:root."/stream")
    return l:root."/stream"
  endif
  return l:root
endfunction

"
" Create a new thing
"
" The file name of the new thing will be date stamped file in the stream
" root. If it's the first of the day then it'll simply be MMDD. If that already
" exists then a file name with full date time will be created.
"
function! s:ThingityNewThing(createNew,type)
  let l:root = s:ThingityGetStreamRoot()
  if a:type == ""
    let postFix = ""
  else
    let postFix = "-".a:type
  endif
  let thingName = l:root."/".strftime("%m%d").postFix.".md"
  let headingExtra = ""
  let isNew = 1
  if filereadable(thingName)
    if a:createNew
      let thingName = l:root."/".toupper(strftime("%Y%m%d-%H%M%S")).".md"
      let headingExtra = " - ".s:ThingityTime()
    else
      let isNew = 0
    endif
  endif
  if a:type != ""
    let headingExtra = headingExtra." - ".a:type
  endif
  " Close current buffer so that new thing opens up with focus
  silent! close
  execute "silent e ".thingName
  if isNew
    execute "normal! a".thingity#GetThingityDateHeading().headingExtra."\<ESC>2o\<ESC>"
    write
  endif
  call NERDTreeFindIfRoom()
  wincmd l
endfunction

"
" TODO : ThingityArchive should be moved to a python script that does a full
" organisations of things.
"
function! s:ThingityArchive()
  let l:root = s:ThingityGetStreamRoot()
  if !isdirectory(l:root."/archive")
    echo "... create stream/archive directory to support archiving"
  endif
  let today = strftime("%m%d")
  let archivePoint = today - 7
  echo archivePoint
  let l:logsToArchive = filter(globpath(l:root, '*.md', 0, 1),"fnamemodify(v:val, ':t') < archivePoint")
  echo l:logsToArchive
  for log in l:logsToArchive
    let l:datePartMatch = matchlist(log,'.*/\([0-9]*\)[\/]*.md')
    if len(l:datePartMatch) > 0
      let l:datePart = l:datePartMatch[1]
      let fullDate = l:datePart
      if len(l:datePart) == 4
        let fullDate = strftime(%Y%).l:datePart
      endif
      echo log
      echo "Date parts ".l:datePart
    endif
  endfor
endfunction

nnoremap <silent> <leader>jd :call <SID>ThingityDateHeading()<CR>
nnoremap <silent> <leader>jn :call <SID>ThingityNewThing(1,"")<CR>
nnoremap <silent> <leader>jj :call <SID>ThingityNewThing(0,"")<CR>
nnoremap <silent> <leader>jk :call <SID>ThingityNewThing(0,"sunrise")<CR>
nnoremap <silent> <leader>jh :call <SID>ThingityNewThing(0,"sunset")<CR>
nnoremap <silent> <leader>ja :call <SID>ThingityArchive()<CR>

" Open NERDTree on my things
nnoremap <silent> <leader>jo :execute 'NERDTree ~/projects/things'<CR>

" Search variations

" just markdown files
nnoremap <silent> <leader>jf :call fzf#vim#files('~/projects/things', {'source':'fd -L .md'})<CR>

command! -bang -nargs=* AgMarkdown
  \ call fzf#vim#ag(<q-args>,
  \  '-p ~/.dotfiles/config/ag/.ignore -G .md',
  \ <bang>0)

nnoremap <silent> <leader>jm :AgMarkdown<CR>

" generic search (experimental alternative to Ag)
nnoremap <silent> <leader>js :Search<CR>

" todos
nnoremap <silent> <leader>jT :Ag! \[\ \]<CR>
" todos
nnoremap <silent> <leader>jt :AgPopup \[\ \]<CR>
