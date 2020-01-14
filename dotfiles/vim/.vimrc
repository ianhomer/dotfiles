"
" Sanity vim configuration
"

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
" Auto reload underlying file if it changes
set autoread

" Do not highlight current line when in insert mode
autocmd InsertEnter,InsertLeave * set cul!

" Map ctrl-j etc to moving between panes, a little quicker than Ctrl-w and
" arrow
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable tab line
let g:airline#extensions#tabline#enabled = 1
" Enable powerfonts giving angled tables
let g:airline_powerline_fonts = 1

" Provide more space for command output (e.g. fugitive) - with it this you may
" need to press ENTER after fugitive commands
set shortmess=a
set cmdheight=2
" Tab support with 2 spaces
set tabstop=2 shiftwidth=2 expandtab
" 80 characters just feels too small for me as a default
set textwidth=120

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" NERDTree config
nmap <F7> :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" fzf config
let $FZF_DEFAULT_COMMAND = 'fd -H --type f'

" Markdown syntax
" Conceal some syntax - e.g. ** around bold
set conceallevel=2
" Enable folding
let g:markdown_folding = 1
" Default large fold level start, folding everything up by default feels odd.
set foldlevelstart=20

" Surround Customisations
" This doesn't work for me - https://stackoverflow.com/questions/32769488/double-vim-surround-with
autocmd Filetype markdown let b:surround_43 = "**\r**"

call plug#begin()

" Adopt : Plugins adopted for general use

" NERDTree - file explore 
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" NERDTree - show git changes
Plug 'Xuyuanp/nerdtree-git-plugin'
" fzf - Fuzzy Finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" ack - Search files
Plug 'mileszs/ack.vim'
" Airline - status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" gitgutter - Git change indicator to left of window
Plug 'airblade/vim-gitgutter'
" editorconfig - Support standard editorconfig files
Plug 'editorconfig/editorconfig-vim'
" polyglot 
Plug 'sheerun/vim-polyglot'
" tabular - Lining up columns 
Plug 'godlygeek/tabular'
" fugitive - Git integration
Plug 'tpope/vim-fugitive'
" symlink - Follow symlink when opening file
Plug 'aymericbeaumet/vim-symlink'
" surround - Surround with brackets etc
Plug 'tpope/vim-surround'
" repeat - Repeat with .
"Plug 'tpope/vim-repeat'
" goyo - Distraction free writing
Plug 'junegunn/goyo.vim'
" gruvbox - styling
Plug 'morhetz/gruvbox'
" Assess : Plugins being assesed as candidates for general use

" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
" Plug 'junegunn/limelight.vim'

call plug#end()

colorscheme gruvbox
set bg=dark



