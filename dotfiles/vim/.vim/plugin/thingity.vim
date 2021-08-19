" Goyo distraction free writing
if knobs#("goyo")
  nnoremap <leader>i :Goyo<CR>
  let g:goyo_width = 85
endif

if !knobs#("thingity")
  finish
endif

if knobs#At(3)
  " Markdown syntax
  " Enable folding
  let g:markdown_folding = 1
  " Default large fold level start, folding everything up by default feels odd.
  set foldlevelstart=2
endif

nnoremap <silent> <leader>jd :call thingity#DateHeading()<CR>
nnoremap <silent> <leader>jn :call thingity#NewThing(1,"")<CR>
nnoremap <silent> <leader>jj :call thingity#NewThing(0,"")<CR>
nnoremap <silent> <leader>jk :call thingity#NewThing(0,"sunrise")<CR>
nnoremap <silent> <leader>jh :call thingity#NewThing(0,"sunset")<CR>
nnoremap <silent> <leader>ja :call thingity#Archive()<CR>

" Open NERDTree on my things
nnoremap <silent> <leader>jo :execute 'NERDTree ~/projects/things'<CR>

" Search variations

" just markdown files
nnoremap <silent> <leader>jf :call fzf#vim#files('~/projects/things', {'source':'fd -L .md'})<CR>

command! -bang -nargs=* AgMarkdown
  \ call fzf#vim#ag(<q-args>,
  \  '-p ~/.dotfiles/config/ag/.ignore -G .md',
  \ <bang>0)

nnoremap <silent> <leader>jm :AgMarkdown<CR>

" generic search (experimental alternative to Ag)
nnoremap <silent> <leader>js :Search<CR>

" todos
nnoremap <silent> <leader>jT :Ag! \[\ \]<CR>
" todos (aligned with task filtering in bin/todo)
nnoremap <silent> <leader>jt :AgPopup \[\ \]<CR>

autocmd BufWritePre,FileWritePre *.md :call thingity#UpdateMeta()

