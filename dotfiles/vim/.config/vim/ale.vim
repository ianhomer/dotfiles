let markdown_linters = ['markdownlint']

" Enable markdown linters that help with good writing
if IsEnabled("writegood")
  let markdown_linters += [
        \ 'alex',
        \ 'languagetool',
        \ 'proselint',
        \ 'writegood'
        \]
endif

let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'json': ['jsonlint'],
  \   'markdown': markdown_linters,
  \   'python': ['flake8'],
  \   'typescript': ['eslint'],
  \   'yaml': ['yamllint']
  \}

let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'javascript': ['eslint'],
  \   'json': ['jq']
  \}

let g:ale_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_jq_use_global = 1

let g:ale_sign_error = '❕'
let g:ale_sign_warning = '❔'

let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_set_quickfix = 1
let g:ale_set_loclist = 0
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_hover_to_preview = 0
let g:ale_lint_on_save = 1

" Rely on autosave triggering linter from lint_on_save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_format = '%s [%severity%] [%linter%]'

" Performance tuning
let g:ale_cache_executable_check_failures = 1
