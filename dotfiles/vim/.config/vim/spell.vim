set spelllang=en,local
set spellfile=~/.config/vim/spell/en.utf-8.add

" 
" Refresh spelling files
"
function! UpdateSpelling()
  let l:spelldir = substitute(g:vim_dir, '\~', $HOME, '') . '/spell' 
  if !isdirectory(l:spelldir)
    echo 'Creating local spell directory ' . l:spelldir
    call mkdir(l:spelldir)
  endif
  let l:dictionaries = ""
  let l:updated = 0
  "
  " Convert all local dictionaries to spell files
  "
  for d in glob('~/.config/dictionaries/*.txt', 1, 1)
    let l:region = l:spelldir . '/'. fnamemodify(d, ":t:r")
    let l:outfile = l:region . '.utf-8.spl'
    let l:dictionaries .= " " . d
    if filereadable(d) && (!filereadable(l:outfile) || getftime(d) > getftime(l:outfile))
      echo d . ":" . fnamemodify(d, ":t:r")
      echo 'Updating '.l:outfile
      exec 'mkspell! ' . l:outfile . ' ' . d
      let l:updated = 1
    endif
  endfor
  "
  " Create single spell file with all local words 
  "
  if l:updated == 1
    let l:localSpell = 'local.utf-8.spl'
    let l:allDictionaries = $TMPDIR . 'all-dictionaries.txt'
    exec '!cat' . l:dictionaries . ' > ' . l:allDictionaries
    echo 'Creating ' . l:localSpell
    exec 'mkspell! ' . l:spelldir . '/' . l:localSpell . ' ' . l:allDictionaries
  endif
endfunction
call UpdateSpelling()

