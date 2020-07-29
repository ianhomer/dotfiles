" Insert time stamp - as markdown header
function! s:ThingityDateHeading()
  " Top level heading if first line
  let heading = line('.') == 1 ? "# " : "## "
  return heading . toupper(strftime("%a %d %b %Y"))
endfunction

function! s:ThingityTime()
  return strftime("%H:%M")
endfunction

"
" Get the root of the project.
"
function! s:ThingityGetRoot()
  echo "get root"
  let l:root = fnameescape(
    \ fnamemodify(finddir('.git', escape(expand('%:p:h'), ' ').";"), ":h"))
  if isdirectory(l:root."/.git")
    return l:root
  endif
  "
  " Find default thing project, which is the first subdirectory that is a git
  " project and has a log directory
  "
  let l:dirs = filter(globpath(getcwd(), '*', 0, 1),"isdirectory(v:val.'/.git') && isdirectory(v:val.'/log')")
  echo l:dirs
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
" Get the thing string root, i.e. log directory if it exists or root otherwise.
function! s:ThingityGetStreamRoot()
  let l:root = s:ThingityGetRoot()
  if isdirectory(l:root."/log")
    return l:root."/log"
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
function! s:ThingityNewThing()
  let l:root = s:ThingityGetStreamRoot()
  let thingName = l:root."/".strftime("%m%d").".md"
  let headingExtra = ""
  if filereadable(thingName)
    let thingName = l:root."/".toupper(strftime("%Y%m%d-%H%M%S")).".md"
    let headingExtra = " - ".s:ThingityTime()
  endif
  close
  execute "e ".thingName
  execute "normal! a".<SID>ThingityDateHeading().headingExtra."\<ESC>2o\<ESC>"
  write
  NERDTreeFind
  wincmd p
endfunction

function! s:ThingityNewLog()

endfunction

nnoremap <silent> <leader>jd "=<SID>ThingityDateHeading()<CR>po<ESC>o<ESC>
nnoremap <leader>jn :call <SID>ThingityNewThing()<CR>

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

" Hidden search
nnoremap <silent> <leader>jh :AgHidden<CR>
" generic search (experimental alternative to Ag)
nnoremap <silent> <leader>ja :Search<CR>

" todos
nnoremap <silent> <leader>jT :Ag! \[\ \]<CR>
" todos
nnoremap <silent> <leader>jt :AgPopup \[\ \]<CR>


