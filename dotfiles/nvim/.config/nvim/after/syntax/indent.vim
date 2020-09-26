" Replace double spaces with a vertical grey dotted line
syntax match leadingSpace /\v^\s\zs\s+/ containedIn=ALL contains=indent

if IsEnabled("light")
  syntax match indent /\v\s\zs\s/ conceal cchar=⋮ contained
  highlight Conceal gui=NONE cterm=NONE guifg=Grey90 ctermfg=249 guibg=NONE
else
  syntax match indent /\v\s\zs\s/ conceal cchar=┊ contained
  highlight Conceal gui=bold cterm=bold guifg=Grey30 ctermfg=249
endif
