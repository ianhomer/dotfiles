if !Knob("spelling")
  finish
endif

set spelllang=en,local
" Set the default spell file. Note that the markdown.vim ftplugin file
" will try also to locate a local spelling file in a .vim directory in a parent
" directory.
set spellfile=~/.config/vim/spell/en.utf-8.add
set complete+=kspell

if Knob("update_spelling") 
  call spelling#Update()
endif

