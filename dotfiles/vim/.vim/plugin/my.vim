command! -nargs=0 ToggleAutoSave :call my#ToggleAutoSave()

" Thanks https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3

function! Grep(...)
  return system(join([&grepprg] + [expandcmd(tolower(join(a:000, ' ')))], ' '))
endfunction
function! Find(...)
  let match = tolower(expandcmd(join(a:000, ' ')))
  return system(join([&grepprg] + ['-G',match..'[^/]*$','--silent','-m','1',match], ' '))
endfunction
command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr Grep(<f-args>)
command! -nargs=0 -bar GrepWord cgetexpr Grep(expand("<cword>"))
command! -nargs=+ -complete=file_in_path -bar Find cgetexpr Find(<f-args>)
command! -nargs=0 -bar FindWord cgetexpr Find(expand("<cword>"))


