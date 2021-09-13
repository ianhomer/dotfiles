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
    if knobs#("toggleterm")
      2TermExec cmd="git push && exit 0"
    else
      Git push
    endif
  else
    Dispatch! Git synk
  endif
endfunction

function my#LintMe()
  if &filetype == "markdown"
    let linter="thingity"
    call thingity#LintMarkdown()
  elseif knobs#("ale")
    let linter="ale"
    ALEFix
  elseif &filetype == "json"
    let linter="jq"
    execute "%!jq ."
  else
    let linter="prune"
    normal ma
    call my#PruneWhiteSpace()
    normal `a
  endif
  echo "Linted ".&filetype." with ".linter
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
  call my#ReduceBlankLines()
endfunction

function my#LintSpace()
  normal ma
  call my#PruneWhiteSpace()
  normal `a
endfunction

function my#ReduceBlankLines()
  call my#TrimEndLines()
  v/\S/,//-j
endfunction

function my#TrimEndLines()
  silent! %s#\($\n\s*\)\+\%$##
endfunction

"
" Save all changed buffers in the given wait period. If this function is
" subsequently called in the given period then first request to save is
" cancelled. This allows the last save to win, without the system burden of
" multiple saves. Note that is also saves all buffers since this brings the
" advantage of (1) making sure all buffers are saved (2) allows saving of buffer
" in background even if you've quickly switched to another buffer.
"
function my#DebouncedSave(wait) abort
  if &buftype == "" && @% != ""
    call timer_stop( s:debouncedSaveTimer )
    let s:debouncedSaveTimer = timer_start(a:wait, { timerId -> execute('wall') })
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
