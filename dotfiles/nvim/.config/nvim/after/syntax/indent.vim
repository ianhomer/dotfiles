syntax match leadingSpace /\v^\s\zs\s+/ contains=indent
syntax match indent /\v\s\zs\s/ conceal cchar=┊ contained
highlight Conceal gui=bold cterm=bold guifg=Grey30 ctermfg=249
