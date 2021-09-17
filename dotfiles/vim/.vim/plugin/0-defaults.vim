if !knobs#("defaults")
  finish
endif

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

" work around for https://github.com/vim/vim/issues/4738
if has('macunix')
  nnoremap gx :call thingity#OpenURLUnderCursor()<CR>
endif

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

if knobs#("minimap")
  nnoremap <silent> <leader>m :MinimapToggle<CR>
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
  command! -nargs=0 ResetMode :call modes#ResetMode()
  command! -nargs=0 PersonalDevMode :call modes#PersonalDevMode()
  command! -nargs=0 MobbingMode :call modes#MobbingMode()
  command! -nargs=0 TrainingMode :call modes#TrainingMode()

  " Numbered modes of configuration
  nnoremap <silent> <leader>1 :ResetMode<CR>
  nnoremap <silent> <leader>2 :PersonalDevMode<CR>
  nnoremap <silent> <leader>3 :MobbingMode<CR>
  nnoremap <silent> <leader>4 :TrainingMode<CR>
endif

let g:minimap_auto_start = 0
let g:minimap_close_filetypes = ['nerdtree','startify']

if knobs#("gutentags")
  let g:gutentags_cache_dir = expand('~/.cache/tags')
endif

if knobs#("dispatch")
  let g:dispatch_no_tmux_make = 1
  let g:dispatch_quickfix_height = 4
endif

if knobs#("gitgutter")
  let g:gitgutter_map_keys = 0
  let g:gitgutter_highlight_linenrs = 1
endif

" markdown preview
let g:mkdp_auto_close = 0
let g:mkdp_page_title = '${name}'

if knobs#("startify")
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

if !knobs#At(2)
  finish
endif

let g:which_key_hspace = 2

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

  autocmd BufNewFile,BufRead *.fish set filetype=fish
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
  autocmd BufNewFile *.sh 0r ~/.vim/skeletons/skeleton.sh
  autocmd BufNewFile *.md 0r ~/.vim/skeletons/skeleton.md


  "
  " *** Scope : Editing ***
  "
  " Do not highlight current line when in insert mode
  autocmd InsertEnter,InsertLeave * set cul!

  " Override shiftwidth for python
  autocmd Filetype python set shiftwidth=4

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
augroup end

"
" *** Scope : Editing ***
"

" Show white space
exec "set listchars=tab:>~,nbsp:~,trail:\uB7"
set list

" Add operator af for all file
onoremap af :<C-u>normal! ggVG<CR>

" Return to visual mode after indenting
vnoremap < <gv
vnoremap > >gv

" Surround customisation
let g:surround_{char2nr('b')} = "**\r**"
let g:surround_{char2nr('<')} = "<\r>"
" Short cuts for surround word
nmap '" ysiW"
nmap "" ysiW"
nmap '' ysiW'
nmap '` ysiW`
nmap '< ysiW<
nmap 'b ysiWb

" *** Scope : IO ***
"
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

" Backspace support
set backspace=indent,eol,start

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

" Thanks to Damian Conway                                                         test long line
set colorcolumn=""
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%82v', 100)

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
