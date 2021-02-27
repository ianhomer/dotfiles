" CORE Configuration - START
"
let mapleader = "\<Space>"
let maplocalleader = "\\"

" Enable mouse support
set mouse=a
" Disable error bells
set noerrorbells
" Enhance command-line completion
set wildmenu
" Highlight current line
set cursorline
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Default updatetime is 4000 and too slow
set updatetime=300
" Quicker timeout between key presses
set timeoutlen=500
" Always show sign column to stop flip-flopping
set signcolumn=yes
if has("nvim")
  " Support true color in nvim only, this feature causes colours to not render
  " in vim in tmux
  set termguicolors
endif
" Keep messages short and don't give ins-completion-messages (c)
set shortmess=catI
" Tab support with 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
" 80 characters default width
set textwidth=80
" Softbreak on space between words
set linebreak
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" I don't use modelines
set nomodeline

if !knobs#At(1)
  finish
endif

"
" CORE Configuration - END
"

" Provide more space for command output (e.g. fugitive) - with it this you may
" need to press ENTER after fugitive commands
if knobs#("compactcmd")
  set cmdheight=1
else
  set cmdheight=2
endif

if !knobs#("nerdtree")
  nnoremap <silent> <leader>f :call knobs#core#SetLevel(5)<CR>
  nnoremap <silent> <leader>n :call knobs#core#SetLevel(5)<CR>
  nnoremap <silent> <leader>s :call knobs#core#SetLevel(5)<CR>
endif

" Start / stop profiling
nnoremap <leader>.p :profile start ~/vim-performance.log<CR>:profile func*<CR>:profile file *<CR>
nnoremap <leader>.o :profile stop<CR>
nnoremap <leader>.i :profile dump<CR>

" save all files
if !knobs#("autosave") | nnoremap <silent> <leader>w :silent! wall<CR> | endif

" reset highlighting
nnoremap <silent> <leader>z :noh<CR>

if knobs#("modes")
  " Numbered modes of configuration
  nnoremap <silent> <leader>1 :call modes#ResetMode()<CR>
  nnoremap <silent> <leader>2 :call modes#PersonalDevMode()<CR>
  nnoremap <silent> <leader>3 :call modes#MobbingMode()<CR>
  nnoremap <silent> <leader>4 :call modes#TrainingMode()<CR>
endif

if knobs#could("nnn")
  let g:nnn#set_default_mappings = 0
  let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6  } }
  nnoremap <silent> <leader>m :NnnPicker<CR>
endif

let g:minimap_auto_start = 1
let g:minimap_close_filetypes = ['nerdtree','startify']

if knobs#could("gutentags")
  let g:gutentags_cache_dir = expand('~/.cache/tags')
endif

if knobs#could("dispatch")
  let g:dispatch_no_tmux_make = 1
  let g:dispatch_quickfix_height = 4
endif

if knobs#could("syntastic")
  let g:vim_jsx_pretty_colorful_config = 1
endif

if knobs#could("gitgutter")
  let g:gitgutter_map_keys = 0
  let g:gitgutter_highlight_linenrs = 1
endif

if knobs#could("conflict-marker")
  autocmd ColorScheme * highlight Info gui=bold guifg=#504945 guibg=#83a598
  let g:conflict_marker_highlight_group="Info"
endif

if KnobAt(5)
  " markdown preview
  let g:mkdp_auto_close = 0
  let g:mkdp_page_title = '${name}'
endif

if !Knob("light")
  if knobs#("gruvbox")
    colorscheme gruvbox
  elseif knobs#("gruvbox8")
    colorscheme gruvbox8
  endif
  set bg=dark
else
  " Light scheme primarily used for writing content
  colorscheme one
  set bg=light
  let $BG_MODE="light"
  let g:one_allow_italics = 1
  call one#highlight('Normal', '000000', 'ffffff', 'none')
  for i in [1,2,3,4,5,6]
    call one#highlight('markdownH'.i, '000000', 'ffffff', 'bold')
  endfor
  call one#highlight('markdownH2', '000000', 'ffffff', 'bold')
  call one#highlight('Directory', '222222', '', 'bold')
  highlight Cursor guibg=grey
  highlight iCursor guibg=black
  set guicursor=n-v-c:block-Cursor
  set guicursor+=i:ver100-iCursor
endif

if !KnobAt(3)
  finish
endif

if Knob("startify")
  let g:startify_custom_header = ""
  let g:startify_session_autoload = 0
  let g:startify_change_to_dir = 0
  let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('my#gitModified'),  'header': ['   git modified']},
        \ { 'type': function('my#gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ { 'type': function('my#nerdtreeBookmarks'),
        \ 'header': ['   NERDTree Bookmarks']}
        \ ]
endif

" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

"
" *** Scope : Windows ***
"
"
" Group all autocmds together to improve reloadability (reloads of vimrc
" replace, not add to, existing commands) and source tacking (we know that
" the autocmds came from here).
"
augroup dotme
  autocmd!

  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

  if KnobAt(3)
    "
    " *** Scope : Editing ***
    "
    " Do not highlight current line when in insert mode
    autocmd InsertEnter,InsertLeave * set cul!
  endif

  if knobs#("autosave")
    "
    " *** Scope : IO ***
    "
    " Auto reload when focus gained or buffer entered
    autocmd FocusGained,WinEnter,BufEnter * :checktime

    " Auto write when text changes using debouncing to wait for pause in text
    " entry. If we save too often then tools that watch for change will get too
    " busy.
    autocmd TextChangedI,TextChangedP * ++nested silent!
      \ call my#DebouncedSave(3000)
    autocmd InsertLeave,TextChanged * ++nested silent! call my#DebouncedSave(500)
  endif

  if KnobAt(3)
    "
    " *** Scope : Python ***
    "

    " Override shiftwidth for python
    autocmd Filetype python set shiftwidth=2
  endif
augroup end

"
" *** Scope : Editing ***
"

" Show white space
if KnobAt(1)
  exec "set listchars=tab:>~,nbsp:~,trail:\uB7"
  set list

  " Add operator af for all file
  onoremap af :<C-u>normal! ggVG<CR>

  " Return to visual mode after indenting
  vnoremap < <gv
  vnoremap > >gv
endif

" Surround customisation
if KnobAt(3)
  let g:surround_{char2nr('b')} = "**\r**"
  let g:surround_{char2nr('<')} = "<\r>"
  " Short cuts for surround word
  if knobs#("which_key")
    nnoremap <silent> ' :WhichKey "'"<CR>
  endif
  nmap '" ysiW"
  nmap "" ysiW"
  nmap '' ysiW'
  nmap '` ysiW`
  nmap '< ysiW<
  nmap 'b ysiWb
endif

" *** Scope : IO ***
"
if KnobAt(1)
  if knobs#("autosave")
    " Auto reload underlying file if it changes, although
    " it only really reloads when external command run like :!ls
    set autoread
    set autowrite
  endif
  " Allow hidden buffers without saving
  set hidden
  " No backups or backups during write
  set nobackup
  set nowritebackup
  " Keep swap and backups centrally
  set backupdir=~/.vim/backups
  set directory=~/.vim/swaps

  " Scroll 3 lines before border
  set scrolloff=3
endif

" Optimise for faster terminal connections
" set ttyfast

"
" *** Scope : Status Bar ***
"

if knobs#("airline")
  " Less accurate highlighting, but improved performance
  let g:airline_highlighting_cache = 1
  " Explicit airline extensions for quicker start up
  let g:airline_extensions = [
         \ "ale",
         \ "branch",
         \ "tabline",
         \ "whitespace",
         \ "wordcount"
         \ ]
  " Enable powerfonts giving angled tab
  let g:airline_powerline_fonts = 1
  let g:airline_skip_empty_sections = 1
  let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
  let g:airline_detect_spell = 0
endif

" Backspace support
if KnobAt(1)
  set backspace=indent,eol,start
endif

" source ~/.config/vim/netrw.vim

if KnobAt(3)
  " Thanks to Damian Conway                                                         test long line
  set colorcolumn=""
  highlight ColorColumn ctermbg=magenta
  call matchadd('ColorColumn', '\%82v', 100)
endif

highlight ErrorMsg ctermbg=grey guibg=grey

" Open new splits to the right and below
set splitright
set splitbelow

" Surround Customisations
" This doesn't work for me -
" https://stackoverflow.com/questions/32769488/double-vim-surround-with
" autocmd Filetype markdown let b:surround_43 = "**\r**"

" Don't conceal any syntax
set conceallevel=0
