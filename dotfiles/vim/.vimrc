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

"
" Subjective vim configuration
"

" Provide more space for command output (e.g. fugitive) - with it this you may
" need to press ENTER after fugitive commands
set shortmess=a
" set cmdheight=2
" Tab support with 2 spaces
set tabstop=2 shiftwidth=2 expandtab

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" NERDTree config
nmap <F7> :NERDTreeToggle<CR>
" Quit NERDTree when opening file - this feels counter-intuitive to me,
" thinkng of removing
" let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" fzf config
let $FZF_DEFAULT_COMMAND = 'fd -H --type f'

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

" Assess : Plugins being assesed as candidates for general use

Plug 'junegunn/goyo.vim'
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
" Plug 'junegunn/limelight.vim'
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
" Plug 'junegunn/goyo.vim'

call plug#end()
