" Leader is space
let mapleader = "\<Space>"
let maplocalleader = "\,"

"
" Load plugins
" vimscript cheatsheet : https://devhints.io/vimscript

let g:vim_dir = "~/.vim"
" Raise slim level to disable configs
" - 9 => core config
" - 8 => core plugins
" - 7 => useful config
" - 6 => useful plugins
" - 5 => power config
" - 4 => power plugins
" - 3 => trial config
"   2 => trial plugins
" - 1 => experimental config
" - 0 => experimental plugins
"
" Slim level can be used to reduce start up times, troubleshoot interactions
" between configurations and plugins. It can also be used to introduce new
" configuration and plugins with control.
"
let g:slim = exists('$VIM_SLIM') ? $VIM_SLIM : exists('g:slim_session') ?
  \ g:slim_session : 6

if has('nvim')
  let g:coc_enabled = g:slim < 5 ? 1 : 0
  "
  " Store nvim plugins in isolated location
  "
  let g:vim_dir = "~/.config/nvim"
else
  let g:coc_enabled = 0
endif

call plug#begin(g:vim_dir."/plugged")

if g:slim < 9
  "
  " Core essentials
  "
  " fzf - Fuzzy Finder
  Plug 'junegunn/fzf'
  Plug 'git@github.com:ianhomer/fzf.vim.git', { 'branch' : 'fix/maps-comment' }
  source ~/.config/vim/fzf.vim

  "
  " Style
  "
  " gruvbox - styling
  Plug 'morhetz/gruvbox'
endif

if g:slim < 7

  "
  " Window and file management
  "

  " NERDTree - file explore
  Plug 'preservim/nerdtree'
  source ~/.config/vim/nerdtree.vim

  Plug 'ryanoasis/vim-devicons'
  " Vinegar - better file expore than NERD
  if g:slim < 1 | Plug 'tpope/vim-vinegar' | endif
  " ack - Search files
  Plug 'mileszs/ack.vim'
  " Airline - status bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " editorconfig - Support standard editorconfig files
  if g:slim < 3 | Plug 'editorconfig/editorconfig-vim' | endif
  " tmux - enable C-hjkl to move to across vim and tmux panes
  Plug 'christoomey/vim-tmux-navigator'
  " Improved path support
  Plug 'tpope/vim-apathy'

  "
  " Help
  "
  " vim-which-key - guidance on what keys do
  Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

  "
  " Coding
  "

  " tabular - Lining up columns
  Plug 'godlygeek/tabular'
  " symlink - Follow symlink when opening file
  Plug 'aymericbeaumet/vim-symlink'
  " surround - Surround with brackets etc
  Plug 'tpope/vim-surround'
  " repeat - Repeat with mapped commands with . not just the native command
  Plug 'tpope/vim-repeat'
  " endwise - auto close structure
  Plug 'tpope/vim-endwise'

  " polyglot
  if g:slim < 3 | Plug 'sheerun/vim-polyglot' | endif
  " fugitive - Git integration
  Plug 'tpope/vim-fugitive'
  " Commenter - loads maps prefixed with <leader>c <- don't use for local maps
  Plug 'preservim/nerdcommenter'
  " NERDTree - show git changes
  if g:slim < 1 | Plug 'xuyuanp/nerdtree-git-plugin' | endif
  " gitgutter - Git change indicator to left of window
  Plug 'airblade/vim-gitgutter'
  " HTML
  if g:slim < 1 | Plug 'mattn/emmet-vim' | endif
  " Linting
  if g:slim < 1 | Plug 'dense-analysis/ale' | endif
  " Handy mappings
  if g:slim < 1 | Plug 'tpope/vim-unimpaired' | endif

  " CoC completion
  if g:coc_enabled == 1
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
  endif

  "
  " Writing
  "
  " goyo - Distraction free writing
  Plug 'junegunn/goyo.vim'
  " markdown preview
  if g:slim < 7 | Plug 'iamcco/markdown-preview.nvim',
        \ { 'do': 'cd app & yarn install' } | endif
endif

call plug#end()

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
" Provide more space for command output (e.g. fugitive) - with it this you may
" need to press ENTER after fugitive commands
set cmdheight=2
" Tab support with 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
" 80 characters default width
set textwidth=80
" Text formating options - no autowrap
set formatoptions=jrql
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed


"
" Command remapping
"
source ~/.config/vim/modes.vim

" Identify free leader mappings
"
nnoremap <silent> <leader>i :echo "i not mapped"<CR>
nnoremap <silent> <leader>k :echo "k not mapped"<CR>
nnoremap <silent> <leader>u :echo "u not mapped"<CR>
nnoremap <silent> <leader>t :echo "t not mapped"<CR>
nnoremap <silent> <leader>y :echo "y not mapped"<CR>

" My shortcuts
if g:slim < 10
  nnoremap <silent> <leader><space> :Buffers<CR>
  nnoremap <silent> <leader>f :Files<CR>
  nnoremap <silent> <leader>F :Files!<CR>

  nnoremap <silent> <leader>,i :call fzf#vim#files('~/projects/things', {'source':'fd -L .md'})<CR>
  " exact
  nnoremap <silent> <leader>je :Ag<CR>'
  nnoremap <silent> <leader>jE :Ag!<CR>'
  " todos
  nnoremap <silent> <leader>jt :Ag<CR>'[\ ]
  nnoremap <silent> <leader>jT :Ag!<CR>'[\ ]


  " save all files
  nnoremap <silent> <leader>s :wall<CR>
  " reset things
  nnoremap <silent> <leader>z :noh<CR>

  " select all
  nnoremap <silent> <leader>o ggVG
  " dummy map
  nnoremap <silent> <leader>9 :echo "9 pressed"<CR>

  " close all buffers
  nnoremap <silent> <leader>x :bufdo bd<CR>
  if g:slim < 8
    nnoremap <silent> <leader>b :BCommits<CR>
    nnoremap <silent> <leader>B :BCommits!<CR>
    nnoremap <silent> <leader>e :Commits<CR>
    nnoremap <silent> <leader>E :Commits!<CR>
    nnoremap <silent> <leader>h :History<CR>
    nnoremap <silent> <leader>r :reg<CR>
    if g:slim < 7
      nnoremap <silent> <leader>n :call NERDTreeFindOrToggle()<CR>
      nnoremap <silent> <leader>,j :execute 'NERDTree ~/projects/things'<CR>
      nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
      nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
    endif
  endif

  nnoremap <silent> <leader>l :call LintMe()<CR>
  nnoremap <leader>.e <C-W><C-=>
endif

if exists('*which_key#register')
  " Note that this currently when config reloaded after which keys as been used
  " since which keys is lazily loaded  
  let g:which_key_map =  {}
  let g:which_key_map.j = { 'name' : '...FZF search' }
  let g:which_key_map[','] = { 'name' : '...Misc' }
  let g:which_key_map['.'] = { 'name' : '...Bookmarked' }
  let g:which_key_map['c'] = { 'name' : '...Commenter' }
  call which_key#register('<Space>', "g:which_key_map")
endif

function! LintMe()
  echo "Linting ..".&filetype
  if g:coc_enabled == 1
    " Lint
    Format
  else
    if &filetype == "json"
      execute "%!jq ."
    elseif &filetype == "markdown"
      normal magggqG`a
    endif
  endif
endfunction

source ~/.config/vim/thingity.vim

" Toggle power slim mode
if !exists("*PowerToggle")
  function! PowerToggle()
    let g:slim_session = exists('g:slim_session') ? g:slim_session > 4 ? 4 : 5 : 4
    call ReloadConfig()
  endfunction
  nnoremap <silent> <leader>p :call PowerToggle()<CR>
endif

" Reload vimrc, neo vimrc and CoC
let g:config_file = has('nvim') ? "~/.config/nvim/init.vim" : "~/.vimrc"
let g:reload_config = "source ".g:config_file
if !exists("*ReloadConfig")
  function! ReloadConfig()
    wall
    exec g:reload_config
    call RestartConfig()
    let config_message = has('nvim') ? "neo init.vm" : ".vimrc"
    let coc_message = g:coc_enabled == 1 ? " with CoC" : ""
    if g:coc_enabled != 1
      " only display message if CoC not enabled, it it is enabled, this extra
      " message causes overload in the 2 row command window
      echo "Reloaded ".config_message.coc_message" - slim = ".g:slim
    endif
  endfunction
endif

function! RestartConfig()
  if g:coc_enabled == 1
    if has('nvim')
      source ~/.config/vim/coc.vim
    endif
    CocRestart
  endif
endfunction

nnoremap <silent> <leader>v :call ReloadConfig()<CR>

" Clear whitespace
if g:slim < 8
  nnoremap <leader>w :%s/\s\+$//g<CR>:nohlsearch<CR>
endif

" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

" *** Scope : Writing ***

" Goyo distraction free writing
if g:slim < 7
  nnoremap <leader>g :Goyo<CR>
  let g:goyo_width = 85
endif

"
" *** Scope : Windows ***
"
if g:slim < 8
  " Thanks - https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
  " Close the current buffer and move to the previous one
  nnoremap <leader>q :<c-u>bp <bar> bd #<cr>
  " Thanks - https://www.rockyourcode.com/vim-close-all-other-buffers/
  " Close all buffers except the current one
  nnoremap <leader>5 :<c-u>up <bar> %bd <bar> e#<cr>
endif

"
" Group all autocmds together to improve reloadability (reloads of vimrc
" replace, not add to, existing commands) and source tacking (we know that
" the autocmds came from here).
"
augroup dotme
  autocmd!

  autocmd BufNewFile,BufRead *.tsx set filetype=typescript

  if g:slim < 8
    "
    " *** Scope : Editing ***
    "
    " Do not highlight current line when in insert mode
    autocmd InsertEnter,InsertLeave * set cul!
  endif

  if g:slim < 8
    "
    " *** Scope : IO ***
    "
    " Auto reload when focus gained or buffer entered
    autocmd FocusGained,BufEnter * :checktime
  endif

  if g:slim < 6
    "
    " *** Scope : Terminal ***
    "
    autocmd BufWinEnter,WinEnter,BufEnter *
          \ if &buftype == 'terminal' | :startinsert | endif
    " autocmd BufWinEnter,WinEnter,BufEnter term://* startinsert
  endif

  if g:slim < 8
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
exec "set listchars=tab:>~,nbsp:~,trail:\uB7"
set list

" Add operator af for all file
onoremap af :<C-u>normal! ggVG<CR>

" Return to visual mode after indenting
vnoremap < <gv
vnoremap > >gv

source ~/.config/vim/spell.vim

" Surround customisation

let b:surround_{char2nr('b')} = "**\r**"
let b:surround_{char2nr('i')} = "*\r*"

nmap <leader>.b ysiWb
nmap <leader>.i ysiWi

" *** Scope : IO ***
"
" Auto reload underlying file if it changes, although
" it only really reloads when external command run like :!ls
set autoread
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

" Optimise for faster terminal connections
" set ttyfast

"
" *** Scope : Status Bar ***
"

if g:slim < 7
  "
  " Enable tab line
  let g:airline#extensions#tabline#enabled = 1
  " Enable powerfonts giving angled tables
  let g:airline_powerline_fonts = 1
endif

" Backspace support
set backspace=indent,eol,start

" CR insert line without leaving normal mode. Note that this
" has special case to append CR at end of line as this feels more
" natural - disabled since non-vi.
" nmap <expr> <CR> getpos('.')[2]==strlen(getline('.')) ?
" "a<CR><Esc>" : "i<CR><Esc>"

" Backspace to delete space without leaving normal mode. At the
" beginning of the line it joins line to previous - disabled since non-vi.
" nmap <expr> <BS> getpos('.')[2]==1 ? "k$gJ" : "hx<Esc>"

" Tab without leaving normal mode
" nnoremap <s-tab> <<
" inoremap <s-tab> <C-d>
" vnoremap <s-tab> <<
" nnoremap <tab> >>
" vnoremap <tab> >>

" source ~/.config/vim/netrw.vim

if g:slim < 7
  "
  " *** Scope : NERDTree ***
  "
  let NERDTreeMinimalUI = 1
  let NERDTreeDirArrows = 1
  let NERDTreeAutoDeleteBuffer = 1
endif

if g:slim < 9
  colorscheme gruvbox
  set bg=dark
endif

if g:slim < 8
  " Thanks to Damian Conway                                                         test long line
  set colorcolumn=""
  highlight ColorColumn ctermbg=magenta
  call matchadd('ColorColumn', '\%82v', 100)
endif

" Open new splits to the right and below
set splitright
set splitbelow

"source ~/.config/vim/terminal.vim

"
" *** Scope : Markdown ***
"

" Surround Customisations
" This doesn't work for me -
" https://stackoverflow.com/questions/32769488/double-vim-surround-with
" autocmd Filetype markdown let b:surround_43 = "**\r**"

" Don't conceal any syntax
set conceallevel=0

if g:slim < 7
  " Markdown syntax
  " Enable folding
  let g:markdown_folding = 1
  " Default large fold level start, folding everything up by default feels odd.
  set foldlevelstart=20
endif

"
" *** Scope : Python ***
"
if g:slim < 2
  source ~/.config/vim/experimental.vim
endif
