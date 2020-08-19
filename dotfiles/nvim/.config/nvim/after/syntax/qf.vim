" Hide filename and location
"syntax match ConcealedDetails /\v^[^|]*\|[^|]*\| / conceal cchar=≢
syntax clear qfFileName
syntax clear qfSeparator
syntax clear qfError
syntax clear qfLineNr
syntax match qfFileName /\v^(\zs[^|]*\ze)\|/ contains=qaPath nextGroup=qfAt
" conceal path before filename
syntax match qaPath /\v(\zs[^|]*\/\ze)/ conceal cchar=‥ contained
" conceal the first pipe
syntax match qfAt /\v(\|.*)@<!\|/ conceal cchar=@ nextGroup=qfLineNr
syntax match qfLineNr /\v(\|)@<=[^\|]*\|/ contains=qfColumn,qfWarning,qfError,qfSecondPipe
" conceal the word warning before the pipe
syntax match qfWarning /\s*warning\s*/ conceal cchar=❔ contained
" conceal the word error before the pipe
syntax match qfError /\s*error\s*/ conceal cchar=❕contained
" conceal the second pipe
syntax match qfSecondPipe /\v(\|.*)@<=\|/ conceal cchar=⼁
" conceal the word col before the pipe
syntax match qfColumn / col / conceal cchar=: contained

syntax match qfTool /\v\[[^\]]*\]$/
hi link qfTool Comment

set conceallevel=1
set concealcursor=nvic
