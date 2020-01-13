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

"
" Subjective vim configuration
"

" Provide more space for command output (e.g. fugitive) - with it this you may
" need to press ENTER after fugitive commands
set shortmess=a
set cmdheight=2
" Tab support with 2 spaces
set tabstop=2 shiftwidth=2 expandtab

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" NERDTree config
nmap <F7> :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" fzf config
let $FZF_DEFAULT_COMMAND = 'fd -H --type f'

call plug#begin()

" Markdown syntax
" Conceal some syntax - e.g. ** around bold
set conceallevel=2
" Enable folding
let g:markdown_folding = 1


" Hold : plasticboy vim-markdown extras
" Set child list indent to 2 spaces when you type o on a list item
" Much of the plastic boy markdown support seems to be now in https://vimawesome.com/plugin/vim-markdown-enchanted
"let g:vim_markdown_new_list_item_indent = 2


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
" goyo - Distraction free writing
Plug 'junegunn/goyo.vim'
" Hold : vim-markdown
"Plug 'plasticboy/vim-markdown'

" Assess : Plugins being assesed as candidates for general use

Plug 'morhetz/gruvbox'
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
" Plug 'junegunn/limelight.vim'
" Plug 'godlygeek/tabular'

call plug#end()

colorscheme gruvbox
:set bg=dark
