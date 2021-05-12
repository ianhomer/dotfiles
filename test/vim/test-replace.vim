" Experimenting with behaviour after undo
" Seems to always jump to first position in the file for the undo block
" 
function ReplaceA()
  let win = winsaveview()
  let l = search('^modified:','b')
  if l > -1
    try 
      undojoin
      call setline(l, substitute(getline(l), 'modified:.*', 'modified: "'.strftime("%a %d %b %Y %H:%M:%S").'"', 'g'))
    endtry
  endif
  call winrestview(win)
endfunction

function ReplaceAA()
  let win = winsaveview()
  let l = search('^modified:','b')
  call winrestview(win)
endfunction

function ReplaceAB()
  let win = winsaveview()
  let l = search('^modified:','b')
  if l > -1
    try 
      undojoin
      keepj call setline(l, substitute(getline(l), 'modified:.*', 'modified: "'.strftime("%a %d %b %Y %H:%M:%S").'"', 'g'))
    catch /^Vim\%((\a\+)\)\=:E790/
    endtry
  endif
  call winrestview(win)
endfunction

function ReplaceABA()
  execute "normal! i "
  execute "normal! a\<BS>"
  let win = winsaveview()
  let l = search('^modified:','b')
  call winrestview(win)
  if l > -1
    try 
      undojoin
      normal iX
      undojoin
      keepj call setline(l, "modified: test")
      call winrestview(win)
      undojoin
      normal iX
    catch /^Vim\%((\a\+)\)\=:E790/
    endtry
  endif
endfunction

function ReplaceABB()
  execute "normal! i "
  execute "normal! a\<BS>"
  let win = winsaveview()
  let l = search('^modified:','b')
  call winrestview(win)
  if l > -1
    try 
      undojoin
      normal iX
      undojoin
      keepj call setline(l, substitute(getline(l), 'modified:.*', 'modified: "'.strftime("%a %d %b %Y %H:%M:%S").'"', 'g'))
      call winrestview(win)
      undojoin
      normal iX
    catch /^Vim\%((\a\+)\)\=:E790/
    endtry
  endif
endfunction

function ReplaceAC()
  let win = winsaveview()
  let l = search('^modified:','b')
  call winrestview(win)
  if l > -1
    try 
      undojoin
      keepj normal iX
    catch /^Vim\%((\a\+)\)\=:E790/
    endtry
  endif
endfunction

function ReplaceB()
  if line("$") > 10
    let l = 10
  else
    let l = line("$")
  endif
  try 
    let win = winsaveview()
    undojoin
    exe "keepj keepp 1," . l . "g/modified:/s/modified:.*/modified: \"".strftime("%a %d %b %Y %H:%M:%S")."\""
    call winrestview(win)
  catch /^Vim\%((\a\+)\)\=:E790/
  endtry
endfunction

function ReplaceC()
  if line("$") > 10
    let l = 10
  else
    let l = line("$")
  endif
  exe "1," . l . "g/id:/s/id:$/id: ".system('uuidgen')
  exe "1," . l . "g/created:/s/created:$/created: \"".strftime("%a %d %b %Y %H:%M:%S")."\""
endfunction

