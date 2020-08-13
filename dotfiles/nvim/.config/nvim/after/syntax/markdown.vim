if g:config_level < 2
  finish
endif

unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml

set conceallevel=0
set concealcursor=nc
