if has_key({}, "chadtree")
endif

finish

if knobs#("chadtree")
endif


finish

if !has('nvim') || !knobs#("chadtree")
  finish
endif

let g:chadtree_settings = {
      \ "theme.text_colour_set" : "nerdtree_syntax_dark"
      \ }

nnoremap <silent> <leader>m <cmd>CHADopen<CR>
