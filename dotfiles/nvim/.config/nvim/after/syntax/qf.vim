" Hide filename and location
"syntax match ConcealedDetails /\v^[^|]*\|[^|]*\| / conceal cchar=≢
" conceal path before filename
syntax match qaPath /\v^[^|]*\// conceal cchar=‥ nextgroup=qfFileName
syntax clear qfFileName
syntax match qfFileName /[^|]\+/ contained nextgroup=qfLocation
" conceal the first pipe
syntax match qfLocation /\v(\|.*)@<!\|/ conceal cchar=@
" conceal the word warning before the pipe
syntax match qfLocation /\v\s*warning\s*(.*\|)@=/ conceal cchar=❔
" conceal the word error before the pipe
syntax match gfLocation /\v\s*error\s*(.*\|)@=/ conceal cchar=❕
" conceal the second pipe
syntax match qfLocation /\v(\|.*)@<=\|/ conceal cchar=⼁
" conceal the word col before the pipe
syntax match ConcealedDetails /\v col (.*\|)@=/ conceal cchar=:

set conceallevel=1
set concealcursor=nvic

