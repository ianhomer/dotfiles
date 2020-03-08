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
Plug 'ryanoasis/vim-devicons'
" Vinegar - better file expore than NERD
" Plug 'tpope/vim-vinegar'
" fzf - Fuzzy Finder
" Use git repo NOT local install since I need https://github.com/junegunn/fzf.vim/issues/92
Plug 'junegunn/fzf'
"Plug '/usr/local/opddt/fzf'
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
" Plug 'tpope/vim-surround'
" repeat - Repeat with .
" Plug 'tpope/vim-repeat'
" HTML
" Plug 'mattn/emmet-vim'
" Linting
" Plug 'dense-analysis/ale'
" Handy mappings
" Plug 'tpope/vim-unimpaired'

" Commenter
" Plug 'preservim/nerdcommenter'

" COC completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-emmet',
      \ 'coc-java',
      \ 'coc-json',
      \ 'coc-prettier',
      \ 'coc-tsserver',
      \ 'coc-yaml'
      \ ]

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
nnoremap <leader>s :w<CR>

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
" Default updatetime is 4000 and too slow
set updatetime=300
" Always show sign column to stop flip-flopping
set signcolumn=yes


"
" Group all autocmds together to improve reloadability (reloads of vimrc
" replace, not add to, exisiting commands) and source tacking (we know that
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
  autocmd BufWinEnter,WinEnter,BufEnter * if &buftype == 'terminal' | :startinsert | endif
  " autocmd BufWinEnter,WinEnter,BufEnter term://* startinsert

augroup end


"
" *** Scope : Editing ***
"

" Show white space
exec "set listchars=tab:>~,nbsp:~,trail:\uB7"
set list

"
" *** Scope : IO ***
" ----------------
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
" COC CONFIG START
" ----------------
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

"
" COC CONFIG END
"

"
" Enable tab line
let g:airline#extensions#tabline#enabled = 1
" Enable powerfonts giving angled tables
let g:airline_powerline_fonts = 1

" Backspace support
set backspace=indent,eol,start

" If we don't want to fix end of lines.
" https://stackoverflow.com/questions/729692/why-should-text-files-end-with-a-newline
" POSIX standard requires it new line at end of file, it's opinionated and
" leads to git diff noise.
"
" set nofixendofline

" CR insert line without leaving normal mode. Note that this
" has special case to append CR at end of line as this feels more
" natural - disabled since non-vi.
" nmap <expr> <CR> getpos('.')[2]==strlen(getline('.')) ? "a<CR><Esc>" : "i<CR><Esc>"

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

"
" netrw config
"
" let g:netrw_liststyle = 3
" let g:netrw_keepdir=0
" When netrw pane hides then close it
" Thanks - https://github.com/tpope/vim-vinegar/issues/13
" autocmd FileType netrw setl bufhidden=wipe
" let g:netrw_fastbrowse = 0

"
" NERDTree config
"
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" fzf config
let $FZF_DEFAULT_COMMAND = 'fd -H --type f'

" Linting
" Fix files with prettier, and then ESLint.
" let b:ale_fixers = ['prettier', 'eslint']


colorscheme gruvbox
set bg=dark
" Thanks to Damian Conway
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%82v', 100)

" Open new splits to the right and below
set splitright
set splitbelow

"
" *** Scope : Terminal ***
"

function! OpenTerminal()
  split
  term
  resize 10
endfunction
nnoremap <silent> <leader>t :call OpenTerminal()<CR>
" Map escape in terminal mode to enter normal mode
tnoremap <Esc> <C-\><C-n>

" File type specific configuration
" ================================
"

" Markdown
" --------
"

" Surround Customisations
" This doesn't work for me - https://stackoverflow.com/questions/32769488/double-vim-surround-with
autocmd Filetype markdown let b:surround_43 = "**\r**"

" Markdown syntax
" Conceal some syntax - e.g. ** around bold
set conceallevel=2
" Enable folding
let g:markdown_folding = 1
" Default large fold level start, folding everything up by default feels odd.
set foldlevelstart=20
nnoremap <silent> <Leader>\ :Tabularize/\|<CR>

"
" Python
" ------
"

" Override shiftwidth for python
autocmd Filetype python set shiftwidth=2


" Experimental configuration
" ==========================
"

" Placeholder for experimental output
function! ShowDebug()
  echo "col=".string(getpos('.')[2]).";pos=".string(getpos('.')).";line-length=".strlen(getline("."))
endfunction
nnoremap <silent> <leader>d :call ShowDebug()<CR>
