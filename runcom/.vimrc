set mouse=a    " Mouse Support

" NERDTree
nmap <F7> :NERDTreeToggle<CR>

call plug#begin()

" Adopt

" NERDTree - file explore 
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" fzf - Fuzzy Finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" ack - Search files
Plug 'mileszs/ack.vim'
" lightline - Status bar
" Plug 'itchyny/lightline.vim'
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

" Assess
Plug 'tpope/vim-surround'
Plug 'junegunn/goyo.vim'
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
" Plug 'junegunn/limelight.vim'
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
" Plug 'junegunn/goyo.vim'

call plug#end()
