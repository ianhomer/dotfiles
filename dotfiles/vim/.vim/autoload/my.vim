if exists('g:my_autoloaded')
  finish
endif
let g:my_autoloaded = 1

function my#SearchFiles()
  call window#SwitchToFirstEditableFile()
  Files
endfunction

function! my#GitSynk(onlyPush)
  call window#cleaner#CloseFugitive()
  if a:onlyPush || !knobs#("dispatch")
    Gpush
  else
    Dispatch! Git synk
  endif
endfunction

function my#LintMe()
  echo "Linted ".&filetype
  if &filetype == "markdown"
    call thingity#LintMarkdown()
  elseif knobs#("coc")
    " Lint
    Format
  elseif knobs#("ale")
    ALEFix
  elseif &filetype == "json"
    execute "%!jq ."
  else
    normal ma
    call PruneWhiteSpace()
    normal `a
  endif
endfunction

function my#ToggleQuickFix()
  let l:currentWindow = winnr('$')
  cwindow
  let l:quickFixWindow = winnr('$')
  if l:currentWindow == l:quickFixWindow
    cclose
  endif
endfunction

function my#ToggleLocationList()
  let l:currentWindow = winnr('$')
  lwindow
  let l:locationListWindow = winnr('$')
  if l:currentWindow == l:locationListWindow
    lclose
  endif
endfunction

" Clear whitespace
function my#PruneWhiteSpace()
  %s/\s\+$//ge
  call ReduceBlankLines()
endfunction

function my#ReduceBlankLines()
  call TrimEndLines()
  v/\S/,//-j
endfunction

function my#TrimEndLines()
  silent! %s#\($\n\s*\)\+\%$##
endfunction

function my#DebouncedSave(wait) abort
  if &buftype == "" && @% != ""
    call timer_stop( s:debouncedSaveTimer )
    let s:debouncedSaveTimer = timer_start(a:wait, { timerId -> execute('write') })
  endif
endf

function my#gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function my#gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" Read ~/.NERDTreeBookmarks file and takes its second column
function my#nerdtreeBookmarks()
  let bookmarks = systemlist("cut -d' ' -f 2 ~/.NERDTreeBookmarks")
  let bookmarks = bookmarks[0:-2] " Slices an empty last line
  return map(bookmarks, "{'line': v:val, 'path': v:val}")
endfunction


