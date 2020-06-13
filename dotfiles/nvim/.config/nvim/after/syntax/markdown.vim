if g:config_level < 2
  finish
endif

if IsEnabled("coc")
  finish
end

unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml
