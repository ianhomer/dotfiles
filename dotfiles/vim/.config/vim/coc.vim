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
      \ 'coc-python',
      \ 'coc-spell-checker',
      \ 'coc-tsserver',
      \ 'coc-yaml',
      \ 'coc-xml'
      \ ]

" Extensions to include
" 'coc-prettier',
" 

" dotfiles dictionaries for cSpell
call coc#config('cSpell.dictionaryDefinitions', [
      \ { "name" : "dotfiles",
      \   "path": expand("$HOME/.config/dictionaries/dotfiles.txt") },
      \ { "name" : "tech",
      \   "path": expand("$HOME/.config/dictionaries/tech.txt") },
      \ { "name" : "inbox",
      \   "path": expand("$HOME/.config/dictionaries/inbox.txt") },
      \ { "name" : "enextra",
      \   "path": expand("$HOME/.config/dictionaries/enextra.txt") }
      \])

" set java home for coc-java
call coc#config('java.home',
      \ expand("$HOME/.jenv/versions/11.0/"))

