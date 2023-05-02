if get(g:, "knobs_level", 0) == 1
  finish
endif

let g:syntax_cmd = "skip"
if exists("g:knob_kanagawa")
  " let g:colors_name='kanagawa'
  " colorscheme "kanagawa"
elseif exists("g:knob_gruvbox")
  try
    "unlet g:syntax_on
    let g:colors_name='gruvbox'
    " Above faster startup (saves 20ms) than using colorscheme
    " since using colorscheme triggers multiple loads of plugin
    "colorscheme gruvbox
  catch /^Vim\%((\a\+)\)\=:E185/
    echo "gruvbox color scheme not loaded, does it need to be installed?"
  endtry
elseif exists("g:knob_gruvbox8")
  let g:colors_name='gruvbox8'
  colorscheme gruvbox8
endif
set bg=dark

" Terminal color 9 (dark red) looks bad on dark
let g:terminal_color_9="#ffb6c1"

highlight ErrorMsg guifg=Grey70
highlight Keyword guifg=Grey90
