set spelllang=en,dottech,dotipsum
set spellfile=~/.config/vim/spell/en.utf-8.add

" Refresh spelling files
function! UpdateSpelling()
  let l:spelldir = substitute(g:vim_dir, '\~', $HOME, '') . '/spell' 
  if !isdirectory(l:spelldir)
    echo 'Creating local spell directory ' . l:spelldir
    call mkdir(l:spelldir)
  endif
  let l:regions = ""
  let l:updated = 0
  for d in glob('~/.config/dictionaries/*.txt', 1, 1)
    let l:region = l:spelldir . '/'. fnamemodify(d, ":t:r")
    let l:outfile = l:region . '.utf-8.spl'
    let l:regions .= " " . l:region
    if filereadable(d) && (!filereadable(l:outfile) || getftime(d) > getftime(l:outfile))
      echo d . ":" . fnamemodify(d, ":t:r")
      echo 'Updating '.l:outfile
      exec 'mkspell! ' . l:outfile . ' ' . d
      let l:updated = 1
    endif
  endfor
  if l:updated == 1
    echo 'mkspell! ' . l:spelldir . '/local.utf-8.spl' . l:regions
    "exec 'mkspell! ' . l:spelldir . '/local.utf-8.spl' . l:regions
  endif
endfunction
call UpdateSpelling()

