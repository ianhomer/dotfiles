if get(g:, "knobs_level", 0) == 1
  finish
endif

if !exists("g:knob_spelling")
  finish
endif

if exists("g:knob_update_spelling") || !spelling#IsInitialised()
  call spelling#Update()
endif

" Set the default spell file. Note that the markdown.vim ftplugin file
" will try also to locate a local spelling file in a .vim directory in a parent
" directory.
set spellfile=~/.config/vim/spell/en.utf-8.add
set spelllang=en,local

set complete+=kspell

set spellcapcheck=
" [.?!]\_[\])'" \t]\+
