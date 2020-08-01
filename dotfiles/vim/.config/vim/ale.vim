let g:ale_linters = {
  \   'javascript': ['eslint'],
  \}

let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'javascript': ['eslint'],
  \}

let g:ale_sign_error = '❕'
let g:ale_sign_warning = '❔'

let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
