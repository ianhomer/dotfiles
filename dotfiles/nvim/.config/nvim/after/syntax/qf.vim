" Hide filename and location
"syntax match ConcealedDetails /\v^[^|]*\|[^|]*\| / conceal cchar=≢
syntax match ConcealedDetails /\v^[^|]*\// conceal cchar=◎
syntax match ConcealedDetails /warning/ conceal cchar=❔
syntax match ConcealedDetails /|/ conceal cchar=⼁
syntax match ConcealedDetails " col " conceal cchar=:


"syntax match ConcealedDetails /\|[^|]*\|/ conceal cchar=➤

"hi ConcealDetails term=bold ctermfg=Red guifg=#80a0ff gui=bold

set conceallevel=1
set concealcursor=nvic

