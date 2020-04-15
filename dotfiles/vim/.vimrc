"
" Load plugins
" vimscript cheatsheet : https://devhints.io/vimscript

let g:vim_dir = "~/.vim"
" Raise slim level to disable configs
let g:slim = 1

if has('nvim')
  let g:coc_enabled = 1
  "
  " Store nvim plugins in isolated location
  "
  let g:vim_dir = "~/.config/nvim"
endif

call plug#begin(g:vim_dir."/plugged")

"
" Window and file navigation
"

" NERDTree - file explore
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'
" Vinegar - better file expore than NERD
" Plug 'tpope/vim-vinegar'
" fzf - Fuzzy Finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" ack - Search files
Plug 'mileszs/ack.vim'
" Airline - status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" editorconfig - Support standard editorconfig files
Plug 'editorconfig/editorconfig-vim'
" tmux - enable C-hjkl to move to across vim and tmux panes
Plug 'christoomey/vim-tmux-navigator'
"
" Coding
"
" polyglot
Plug 'sheerun/vim-polyglot'
" tabular - Lining up columns
Plug 'godlygeek/tabular'
" fugitive - Git integration
Plug 'tpope/vim-fugitive'
" NERDTree - show git changes
"Plug 'xuyuanp/nerdtree-git-plugin'
" gitgutter - Git change indicator to left of window
"Plug 'airblade/vim-gitgutter'
" symlink - Follow symlink when opening file
Plug 'aymericbeaumet/vim-symlink'
" surround - Surround with brackets etc
Plug 'tpope/vim-surround'
" repeat - Repeat with .
Plug 'tpope/vim-repeat'
" HTML
" Plug 'mattn/emmet-vim'
" Linting
" Plug 'dense-analysis/ale'
" Handy mappings
" Plug 'tpope/vim-unimpaired'

" Commenter
" Plug 'preservim/nerdcommenter'

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
Plug 'junegunn/goyo.vim'

" tabular - lining up text
Plug 'godlygeek/tabular'
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
"
" Style
"
" gruvbox - styling
Plug 'morhetz/gruvbox'

call plug#end()

"
" Command remapping
"

" Leader is space
let mapleader = "\<Space>"

" Semi-colon is easier for commands
nnoremap ; :

" My shortcuts
nnoremap <silent> <leader><space> :Buffers<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :BCommits<CR>
nnoremap <silent> <leader>c :Commits<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>m :Maps<CR>
nnoremap <silent> <leader>r :reg<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>s :w<CR>

" Reload vimrc, neo vimrc and coc
if has('nvim')
  if g:coc_enabled == 1
    nnoremap <leader>vc
      \ :source ~/.config/nvim/init.vim<CR>:CocRestart<CR>
      \ :echo "Reloaded neo init.vm"<CR>
  else
    nnoremap <leader>vc
      \ :source ~/.config/nvim/init.vim<CR>
      \ :echo "Reloaded neo init.vm"<CR>
  endif
else
  if g:coc_enabled == 1
    nnoremap <leader>vc
      \ :source ~/.vimrc<CR>:CocRestart<CR>:echo "Reloaded .vimrc"<CR>
  else
    nnoremap <leader>vc
      \ :source ~/.vimrc<CR>:echo "Reloaded .vimrc"<CR>
  endif
endif

" Clear whitespace
nnoremap <Leader>cw :%s/\s\+$//g<CR>:nohlsearch<CR>

" *** Scope : Writing ***

" Goyo distraction free writing
if g:slim < 9
  nnoremap <leader>g :Goyo<CR>
  let g:goyo_width = 85
endif

"
" *** Scope : Windows ***
"

" Thanks - https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
" Close the current buffer and move to the previous one
nnoremap <leader>bq :<c-u>bp <bar> bd #<cr>
" Show all open buffers and their status
nnoremap <leader>bl :ls<cr>
" Thanks - https://www.rockyourcode.com/vim-close-all-other-buffers/
" Close all buffers except the current one
nnoremap <leader>bd :<c-u>up <bar> %bd <bar> e#<cr>

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
" Support true color
set termguicolors

"
" Group all autocmds together to improve reloadability (reloads of vimrc
" replace, not add to, existing commands) and source tacking (we know that
" the autocmds came from here).
"
augroup dotme
  autocmd!
  "
  " *** Scope : Editing ***
  "
  " Do not highlight current line when in insert mode
  autocmd InsertEnter,InsertLeave * set cul!

  "
  " *** Scope : IO ***
  "
  " Auto reload when focus gained or buffer entered
  au FocusGained,BufEnter * :checktime

  "
  " *** Scope : Terminal ***
  "
  autocmd BufWinEnter,WinEnter,BufEnter *
        \ if &buftype == 'terminal' | :startinsert | endif
  " autocmd BufWinEnter,WinEnter,BufEnter term://* startinsert

  "
  " *** Scope : Python ***
  "

  " Override shiftwidth for python
  autocmd Filetype python set shiftwidth=2
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

"
" Enable tab line
let g:airline#extensions#tabline#enabled = 1
" Enable powerfonts giving angled tables
let g:airline_powerline_fonts = 1

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

"
" *** Scope : NERDTree ***
"
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" fzf config
let $FZF_DEFAULT_COMMAND = 'fd -H --type f'

colorscheme gruvbox
set bg=dark
" Thanks to Damian Conway                                                         test long line
set colorcolumn=""
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%82v', 100)

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

" Markdown syntax
" Conceal some syntax - e.g. ** around bold
set conceallevel=2
" Enable folding
let g:markdown_folding = 1
" Default large fold level start, folding everything up by default feels odd.
set foldlevelstart=20
nnoremap <silent> <Leader>\ :Tabularize/\|<CR>

"
" *** Scope : Python ***
"
" Disable python2 support
" let g:loaded_python_provider = 0

source ~/.config/vim/experimental.vimrc

