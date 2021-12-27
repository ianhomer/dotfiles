if get(g:, "knobs_level" > 2)
  command! -nargs=0 LintSpace :call my#LintSpace()
  nnoremap <leader>L :LintSpace<CR>
endif

if !exists("g:knob_ale")
  finish
endif

let g:ale_sign_error = '❕'
let g:ale_sign_warning = '❔'
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_lint_on_save = 1

" Rely on autosave triggering linter from lint_on_save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_format = 'ALE : %s [%severity%] [%linter%]'

let g:ale_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_jq_use_global = 1

"let g:ale_markdown_remark_lint_use_global = 1
"let g:ale_markdown_remark_lint_executable = "remark"
let g:ale_markdown_remark_lint_options = "-r ~/.config/remarkrc.js"

let g:ale_set_quickfix = 1
let g:ale_set_loclist = 0
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_hover_to_preview = 0

let g:ale_python_flake8_options = "--append-config ~/.config/flake8"

" Performance tuning
let g:ale_cache_executable_check_failures = 1

if has('nvim')
  highlight ALEWarning gui=undercurl guifg=255
  " LSP for neovim is better
  let js_linters = []
else
  let js_linters = ['eslint']
endif

"let markdown_linters = ['remark-lint']
let markdown_linters = ['']

" Enable markdown linters that help with good writing
if knobs#("writegood")
  " Excluded 'languagetool'
  let markdown_linters += [
        \ 'alex',
        \ 'proselint',
        \ 'writegood'
        \]
endif

let g:ale_linters = {
  \   'html': ['tidy'],
  \   'javascript': js_linters,
  \   'json': ['jsonlint'],
  \   'lua': ['luac'],
  \   'markdown': markdown_linters,
  \   'python': ['flake8'],
  \   'typescript': js_linters,
  \   'yaml': ['yamllint']
  \}

let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'css': ['prettier'],
  \   'html': ['prettier'],
  \   'javascript': ['eslint', 'prettier'],
  \   'json': ['jq'],
  \   'lua': ['luafmt'],
  \   'markdown': ['remark-lint'],
  \   'python': ['black'],
  \   'scss': ['prettier'],
  \   'typescript': ['eslint', 'prettier']
  \}

