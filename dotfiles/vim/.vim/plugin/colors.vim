if !knobs#At(1)
  finish
endif

let g:syntax_cmd = "skip"
if knobs#("gruvbuddy") || knobs#("material")
  " no-op - done in init.lua
elseif knobs#("zephyr")
  colorscheme zephyr
elseif knobs#("gruvbox")
  try
    "unlet g:syntax_on
    let g:colors_name='gruvbox'
    " Above faster startup (saves 20ms) than using colorscheme
    " since using colorscheme triggers multiple loads of plugin
    "colorscheme gruvbox
  catch /^Vim\%((\a\+)\)\=:E185/
    echo "gruvbox color scheme not loaded, does it need to be installed?"
  endtry
elseif knobs#("gruvbox8")
  let g:colors_name='gruvbox8'
  " colorscheme gruvbox8
endif
set bg=dark
highlight ErrorMsg guibg=Grey80 guifg=Grey20
