source ~/.config/vim/coc-core.vim

let g:coc_global_extensions = [
      \ 'coc-actions',
      \ 'coc-css',
      \ 'coc-emmet',
      \ 'coc-markdownlint',
      \ 'coc-highlight',
      \ 'coc-html',
      \ 'coc-java',
      \ 'coc-json',
      \ 'coc-prettier',
      \ 'coc-python',
      \ 'coc-spell-checker',
      \ 'coc-tsserver',
      \ 'coc-yaml',
      \ 'coc-xml'
      \ ]

" dotfiles dictionaries for cSpell
call coc#config('cSpell.dictionaryDefinitions', [
      \ { "name" : "dotfiles",
      \   "path": expand("$HOME/.config/dictionaries/dotfiles.txt") },
      \ { "name" : "dottech",
      \   "path": expand("$HOME/.config/dictionaries/dottech.txt") },
      \ { "name" : "dotinbox",
      \   "path": expand("$HOME/.config/dictionaries/dotinbox.txt") },
      \ { "name" : "doten",
      \   "path": expand("$HOME/.config/dictionaries/doten.txt") }
      \])

" set java home for coc-java
call coc#config('java.home',
      \ expand("$HOME/.jenv/versions/11.0/"))

