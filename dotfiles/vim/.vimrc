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
  Plug 'junegunn/fzf.vim'
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
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
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

  "
  " Coding

  "
  " polyglot
  if g:slim < 5 | Plug 'sheerun/vim-polyglot' | endif
  " tabular - Lining up columns
  if g:slim < 5 | Plug 'godlygeek/tabular' | endif
  " fugitive - Git integration
  if g:slim < 5 | Plug 'tpope/vim-fugitive' | endif
  " NERDTree - show git changes
  if g:slim < 1 | Plug 'xuyuanp/nerdtree-git-plugin' | endif
  " gitgutter - Git change indicator to left of window
  if g:slim < 1 | Plug 'airblade/vim-gitgutter' | endif
  " symlink - Follow symlink when opening file
  Plug 'aymericbeaumet/vim-symlink'
  " surround - Surround with brackets etc
  if g:slim < 5 | Plug 'tpope/vim-surround' | endif
  " repeat - Repeat with .
  if g:slim < 5 | Plug 'tpope/vim-repeat' | endif
  " HTML
  if g:slim < 1 | Plug 'mattn/emmet-vim' | endif
  " Linting
  if g:slim < 1 | Plug 'dense-analysis/ale' | endif
  " Handy mappings
  if g:slim < 1 | Plug 'tpope/vim-unimpaired' | endif
  " Commenter
  if g:slim < 5 | Plug 'preservim/nerdcommenter' | endif

  " COC completion
  if g:coc_enabled == 1
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [
        \ 'coc-actions',
        \ 'coc-css',
        \ 'coc-emmet',
        \ 'coc-markdownlint',
        \ 'coc-highlight',
        \ 'coc-html',
        \ 'coc-java',
        \ 'coc-json',
        \ 'coc-prettier',
        \ 'coc-python',
        \ 'coc-spell-checker',
        \ 'coc-tsserver',
        \ 'coc-yaml',
        \ 'coc-xml'
        \ ]
  endif

  "
  " Writing
  "
  " goyo - Distraction free writing
  if g:slim < 7 | Plug 'junegunn/goyo.vim' | endif
  " tabular - lining up text
  if g:slim < 5 | Plug 'godlygeek/tabular' | endif
  " mardown preview
  if g:slim < 1 | Plug 'iamcco/markdown-preview.nvim',
        \ { 'do': 'cd app & yarn install' } | endif
endif

call plug#end()

"
" Command remapping
"

" Leader is space
let mapleader = "\<Space>"

" Semi-colon is easier for commands
nnoremap ; :

" My shortcuts
if g:slim < 10
  nnoremap <silent> <leader><space> :Buffers<CR>
  nnoremap <silent> <leader>f :Files<CR>
  if g:slim < 8
    nnoremap <silent> <leader>b :BCommits<CR>
    nnoremap <silent> <leader>c :Commits<CR>
    nnoremap <silent> <leader>h :History<CR>
    nnoremap <silent> <leader>m :Maps<CR>
    nnoremap <silent> <leader>r :reg<CR>
    nnoremap <leader>s :w<CR>
    if g:slim < 7
      nnoremap <leader>n :NERDTreeToggle<CR>
    endif
  endif
endif

" Toggle power slim mode
function! PowerToggle()
  let g:slim_session = exists('g:slim_session') ? g:slim_session > 4 ? 4 : 5 : 4
  echo "Current slim ".g:slim." - reload config to change to ".g:slim_session
endfunction
nnoremap <silent> <leader>p :call PowerToggle()<CR>

" Reload vimrc, neo vimrc and coc
if has('nvim')
  if g:coc_enabled == 1
    nnoremap <leader>vc
      \ :source ~/.config/nvim/init.vim<CR>:CocRestart<CR>
      \ :echo "Reloaded neo init.vm with CoC - slim = ".g:slim<CR>
  else
    nnoremap <leader>vc
      \ :source ~/.config/nvim/init.vim<CR>
      \ :echo "Reloaded neo init.vm - slim = ".g:slim<CR>
  endif
else
  if g:coc_enabled == 1
    nnoremap <leader>vc
      \ :source ~/.vimrc<CR>:CocRestart<CR>
      \ :echo "Reloaded .vimrc - slim = ".g:slim<CR>
  else
    nnoremap <leader>vc
      \ :source ~/.vimrc<CR>
      \ :echo "Reloaded .vimrc - slim = ".g:slim<CR>
  endif
endif

" Clear whitespace
if g:slim < 8
  nnoremap <Leader>cw :%s/\s\+$//g<CR>:nohlsearch<CR>
endif

" *** Scope : Writing ***

" Goyo distraction free writing
if g:slim < 7
  nnoremap <leader>g :Goyo<CR>
  let g:goyo_width = 85
endif

"
" *** Scope : Windows ***
"
if g:slim < 6
  " Thanks - https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
  " Close the current buffer and move to the previous one
  nnoremap <leader>bq :<c-u>bp <bar> bd #<cr>
  " Show all open buffers and their status
  nnoremap <leader>bl :ls<cr>
  " Thanks - https://www.rockyourcode.com/vim-close-all-other-buffers/
  " Close all buffers except the current one
  nnoremap <leader>bd :<c-u>up <bar> %bd <bar> e#<cr>
endif

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
" Always show sign column to stop flip-flopping
set signcolumn=yes
if has("nvim")
  " Support true color in nvim only, this feature causes colours to not render
  " in vim in tmux
  set termguicolors
endif

"
" Group all autocmds together to improve reloadability (reloads of vimrc
" replace, not add to, existing commands) and source tacking (we know that
" the autocmds came from here).
"
augroup dotme
  autocmd!

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

"
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

if g:coc_enabled == 1
  source ~/.config/vim/coc.vimrc
endif

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

" source ~/.config/vim/netrw.vimrc

if g:slim < 7
  "
  " *** Scope : NERDTree ***
  "
  let NERDTreeMinimalUI = 1
  let NERDTreeDirArrows = 1
endif

if g:slim < 9
  " fzf config
  let $FZF_DEFAULT_COMMAND = 'fd -H --type f'

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

"source ~/.config/vim/terminal.vimrc

"
" *** Scope : Markdown ***
"

" Surround Customisations
" This doesn't work for me -
" https://stackoverflow.com/questions/32769488/double-vim-surround-with
" autocmd Filetype markdown let b:surround_43 = "**\r**"

if g:slim < 7
  " Markdown syntax
  " Conceal some syntax - e.g. ** around bold
  set conceallevel=2

  " Enable folding
  let g:markdown_folding = 1
  " Default large fold level start, folding everything up by default feels odd.
  set foldlevelstart=20

  if g:slim < 5
    nnoremap <silent> <Leader>\ :Tabularize/\|<CR>
  endif
endif

"
" *** Scope : Python ***
"
" Disable python2 support
" let g:loaded_python_provider = 0

if g:slim < 2
  source ~/.config/vim/experimental.vimrc
endif

