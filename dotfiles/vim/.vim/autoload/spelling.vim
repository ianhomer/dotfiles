"
" Refresh spelling files
"
function spelling#GetSpellingDirectoryName()
  return $HOME . "/.config/" . (has("nvim") ? "nvim" : "vim") . '/spell'
endfunction

function spelling#IsInitialised()
  return filereadable(spelling#GetSpellingDirectoryName() . '/local.utf-8.spl')
endfunction

function! spelling#Update()
  let l:spelldir = spelling#GetSpellingDirectoryName()
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
  let l:localSpell = 'local.utf-8.spl'
  let l:localSpellFullName = l:spelldir . '/' . l:localSpell
  if l:updated == 1 || !filereadable(l:localSpellFullName)
    let l:allDictionaries = $TMPDIR . 'all-dictionaries.txt'
    exec '!cat' . l:dictionaries . ' > ' . l:allDictionaries
    echo 'Creating ' . l:localSpell
    exec 'mkspell! ' . l:localSpellFullName . ' ' . l:allDictionaries
  endif
endfunction
