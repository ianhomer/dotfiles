if g:config_level < 2
  finish
endif

if g:coc_enabled == 1
  finish
end

unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml
