if !knobs#At(9)
  finish
endif

hi clear Conceal

unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml

" Markdown list rendering
if knobs#("markdown_syntax_list")
  syntax match mdList /^\s*-\s.*/ contains=mdListBullet
  syntax match mdListBullet /\v^\s*\zs-\ze/ contained conceal cchar=•
  syntax match mdTodo /\v^\zs\s*-\s\[.+\]\ze/ contains=mdTodoStart,mdTodoDone,mdTodoNotDone
  syntax match mdTodoStart /\v^\s*\zs-\ze/ contained conceal nextgroup=mdTodoDone,mdTodoNotDone
  syntax match mdTodoNotDone /\v\s\[\s\]/ contained cchar=☐ conceal
  syntax match mdTodoDone /\v\s\[x\]/ contained cchar=☑︎ conceal
endif

" Markdown table rendering
if knobs#("markdown_syntax_table")
  syntax match mdTableRow /\v^\|.*/ contains=mdTableColumn
  syntax match mdTableColumn /\v\|/ contained conceal cchar=│
  syntax match mdTableHeader /\v^\|\s--.*\|/ contains=mdTableHeaderStart,mdTableHeaderEnd,mdTableHeaderMiddle,mdTableHeaderMinus,mdTableHeaderSpace
  syntax match mdTableHeaderEnd /\v\zs\|\ze$/ contained conceal cchar=┤
  syntax match mdTableHeaderMiddle /\v\zs\|\ze\s/ contained conceal cchar=┼
  syntax match mdTableHeaderStart /\v^\zs\|\ze\s+-/ contained conceal cchar=├
  syntax match mdTableHeaderMinus /-/ contained conceal cchar=─
  syntax match mdTableHeaderMinus /\s/ contained conceal cchar=─
endif


