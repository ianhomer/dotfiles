"
" Load plugins
"

let g:vim_dir = "~/.vim"

if has('nvim')
  let g:vim_dir = "~/.config/nvim"
endif

call plug#begin(g:vim_dir."/plugged")

"
" Window and file navigation
"

" NERDTree - file explore
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Vinegar - file expore
Plug 'tpope/vim-vinegar'
" fzf - Fuzzy Finder
Plug '/usr/local/opt/fzf'
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
Plug 'Xuyuanp/nerdtree-git-plugin'
" gitgutter - Git change indicator to left of window
Plug 'airblade/vim-gitgutter'
" symlink - Follow symlink when opening file
Plug 'aymericbeaumet/vim-symlink'
" surround - Surround with brackets etc
Plug 'tpope/vim-surround'
" repeat - Repeat with .
"Plug 'tpope/vim-repeat'
" HTML
Plug 'mattn/emmet-vim'
" Linting
"Plug 'dense-analysis/ale'
"let b:ale_fixers = ['prettier', 'eslint']
" Handy mappings
Plug 'tpope/vim-unimpaired'

" Commenter
Plug 'preservim/nerdcommenter'

if has('nvim')
  " Code completion
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Some people suggest deoplete ...
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
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
nnoremap <silent> <leader>c :Commits<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>m :Maps<CR>
nnoremap <silent> <leader>r :reg<CR>
nnoremap <silent> <leader>a :Ag<CR>
nnoremap <leader>n :NERDTreeToggle<CR>

" Reload vimrc or neo vimrc
if has('nvim')
  nnoremap <leader>vc :source ~/.config/nvim/init.vim<CR>:echo "Reloaded neo init.vm"<CR>
else
  nnoremap <leader>vc :source ~/.vimrc<CR>:echo "Reloaded .vimrc"<CR>
endif

" Clear whitespace
nnoremap <Leader>cw :%s/\s\+$//g<CR>:nohlsearch<CR>
" Goyo distraction free writing
nnoremap <leader>g :Goyo<CR>

"
" Window and navigation
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
" Auto reload underlying file if it changes, although
" it only really reloads when external command run like :!ls
set autoread
" Auto reload when focus gained or buffer entered
au FocusGained,BufEnter * :checktime
" Do not highlight current line when in insert mode
autocmd InsertEnter,InsertLeave * set cul!
" Allow hidden buffers without saving
set hidden
" Optimise for faster terminal connections
set ttyfast
" Keep swap and backups centrally
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
" Scroll 3 lines before border
set scrolloff=3

" Show white space
exec "set listchars=tab:>~,nbsp:~,trail:\uB7"
set list

" Enable tab line
let g:airline#extensions#tabline#enabled = 1
" Enable powerfonts giving angled tables
let g:airline_powerline_fonts = 1

" Backspace support
set backspace=indent,eol,start

" CR insert line without leaving normal mode. Note that this
" has special case to append CR at end of line as this feels more
" natural.
nmap <expr> <CR> getpos('.')[2]==strlen(getline('.')) ? "a<CR><Esc>" : "i<CR><Esc>"

" Backspace to delete space without leaving normal mode. At the
" beginning of the line it joins line to previous.
nmap <expr> <BS> getpos('.')[2]==1 ? "k$gJ" : "hx<Esc>"

" Tab without leaving normal mode
nnoremap <s-tab> <<
inoremap <s-tab> <C-d>
vnoremap <s-tab> <<
nnoremap <tab> >>
vnoremap <tab> >>

" Keep messages short
set shortmess=atI

" Provide more space for command output (e.g. fugitive) - with it this you may
" need to press ENTER after fugitive commands
set cmdheight=2
" Tab support with 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
" 80 characters default width
set textwidth=80

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" NERDTree config
nmap <F7> :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" fzf config
let $FZF_DEFAULT_COMMAND = 'fd -H --type f'

" Linting
" Fix files with prettier, and then ESLint.
let b:ale_fixers = ['prettier', 'eslint']

" Markdown syntax
" Conceal some syntax - e.g. ** around bold
set conceallevel=2
" Enable folding
let g:markdown_folding = 1
" Default large fold level start, folding everything up by default feels odd.
set foldlevelstart=20
nnoremap <silent> <Leader>\ :Tabularize/\|<CR>

colorscheme gruvbox
set bg=dark
" Thanks to Damian Conway
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%82v', 100)

"
" File type specific loads
"

" Surround Customisations
" This doesn't work for me - https://stackoverflow.com/questions/32769488/double-vim-surround-with
autocmd Filetype markdown let b:surround_43 = "**\r**"

" Override shiftwidth for python
autocmd Filetype python set shiftwidth=2

" Placeholder for experimental output
function! ShowDebug()
  echo "col=".string(getpos('.')[2]).";pos=".string(getpos('.')).";line-length=".strlen(getline("."))
endfunction
nnoremap <silent> <leader>d :call ShowDebug()<CR>

