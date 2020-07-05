let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_highlighting = 1

let g:syntastic_error_symbol = '❕'
let g:syntastic_style_error_symbol = '!'
let g:syntastic_warning_symbol = '❔'
let g:syntastic_style_warning_symbol = "?"

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_markdown_checkers = []
let g:syntastic_sh_checkers = ['sh']
let g:syntastic_typescript_checkers = ['eslint']
let g:syntastic_yaml_checkers = ['jsyaml']
" Syntastic javac and checkstyle don't feel good enough (:h
" syntastic-java-javac and syntastic-java-checkstyle), so we'll
" go without. Enabled CoC with space-5 to get a better experience.
let g:syntastic_java_checkers = []

"let g:syntastic_markdown_mdl_exec = "markdownlint"
"let g:syntastic_markdown_mdl_args = ""
"
