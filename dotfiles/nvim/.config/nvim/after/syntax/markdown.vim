if g:config_level < 2
  finish
endif

unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml

set conceallevel=1
set concealcursor=nc

" Markdown table rendering
syntax match markdownTableRow /\v^(\zs\|[^-]+\|\ze)/ contains=markdownTableColumn
syntax match markdownTableColumn /\v\|/ contained conceal cchar=│
syntax match markdownTableHeader /\v^\|.*--.*\|/ contains=markdownTableHeaderStart,markdownTableHeaderEnd,markdownTableHeaderMiddle,markdownTableHeaderMinus,markdownTableHeaderSpace
syntax match markdownTableHeaderEnd /\v\zs\|\ze$/ contained conceal cchar=┤
syntax match markdownTableHeaderMiddle /\v\zs\|\ze\s/ contained conceal cchar=┼
syntax match markdownTableHeaderStart /\v^\zs\|\ze\s+-/ contained conceal cchar=├
syntax match markdownTableHeaderMinus /-/ contained conceal cchar=─
syntax match markdownTableHeaderMinus /\s/ contained conceal cchar=─


