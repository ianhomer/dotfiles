if g:config_level < 2
  finish
endif

hi clear Conceal

unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml

set conceallevel=2
set concealcursor=nc

" Markdown list rendering
syntax match mdList /^-\s.*/ contains=mdListBullet
syntax match mdListBullet /\v^\zs-\ze/ contained conceal cchar=●
syntax match mdTodo /\v^\zs-\s\[.+\]\ze/ contains=mdTodoStart,mdTodoDone,mdTodoNotDone
syntax match mdTodoStart /\v^\zs-\ze/ contained conceal nextgroup=mdTodoDone,mdTodoNotDone
syntax match mdTodoNotDone /\v\s\[\s\]/ contained cchar=◻︎ conceal
syntax match mdTodoDone /\v\s\[x\]/ contained cchar=☑︎ conceal

" Markdown table rendering
syntax match mdTableRow /\v^\|.*\|/ contains=mdTableColumn
syntax match mdTableColumn /\v\|/ contained conceal cchar=│
syntax match mdTableHeader /\v^\|\s--.*\|/ contains=mdTableHeaderStart,mdTableHeaderEnd,mdTableHeaderMiddle,mdTableHeaderMinus,mdTableHeaderSpace
syntax match mdTableHeaderEnd /\v\zs\|\ze$/ contained conceal cchar=┤
syntax match mdTableHeaderMiddle /\v\zs\|\ze\s/ contained conceal cchar=┼
syntax match mdTableHeaderStart /\v^\zs\|\ze\s+-/ contained conceal cchar=├
syntax match mdTableHeaderMinus /-/ contained conceal cchar=─
syntax match mdTableHeaderMinus /\s/ contained conceal cchar=─


