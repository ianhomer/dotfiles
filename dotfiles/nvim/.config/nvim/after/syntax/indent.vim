" Replace double spaces with a vertical grey dotted line
syntax match leadingSpace /\v^\s\zs\s+/ containedIn=ALL contains=indent
syntax match indent /\v\s\zs\s/ conceal cchar=┊ contained
highlight Conceal gui=bold cterm=bold guifg=Grey30 ctermfg=249
