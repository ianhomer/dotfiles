if !knobs#At(1)
  finish
endif

if knobs#("light")
  " Light scheme primarily used for writing content
  colorscheme one
  set bg=light
  let $BG_MODE="light"
  let g:one_allow_italics = 1
  call one#highlight('Normal', '000000', 'ffffff', 'none')
  for i in [1,2,3,4,5,6]
    call one#highlight('markdownH'.i, '000000', 'ffffff', 'bold')
  endfor
  call one#highlight('markdownH2', '000000', 'ffffff', 'bold')
  call one#highlight('Directory', '222222', '', 'bold')
  highlight Cursor guibg=grey
  highlight iCursor guibg=black
  set guicursor=n-v-c:block-Cursor
  set guicursor+=i:ver100-iCursor
else
  if knobs#("gruvbuddy")
    " no-op - done in init.lua
  elseif knobs#("zephyr")
    colorscheme zephyr
  elseif knobs#("gruvbox")
    try
      let g:syntax_cmd = "skip"
      "unlet g:syntax_on
      let g:colors_name='gruvbox'
      " Above faster startup (saves 20ms) than using colorscheme
      " since using colorscheme triggers multiple loads of plugin
      "colorscheme gruvbox
    catch /^Vim\%((\a\+)\)\=:E185/
      echo "gruvbox color scheme not loaded, does it need to be installed?"
    endtry
  elseif knobs#("gruvbox8")
    let g:syntax_cmd = "skip"
    let g:colors_name='gruvbox8'
    " colorscheme gruvbox8
  endif
  set bg=dark
  "finish
endif

