if has('nvim')
  " Store nvim plugins in isolated location
  let g:vim_dir = "~/.config/nvim"
else
  let g:vim_dir = "~/.vim"
endif

let mapleader = "\<Space>"
let maplocalleader = "\\"

source ~/.config/vim/toggle.vim

if g:config_level > 0
  filetype plugin on
  filetype plugin off
endif

" Load plugins
call plug#begin(g:vim_dir."/plugged")
if g:config_level > 0
  "
  " Core essentials
  "
  " fzf - Fuzzy Finder
  Plug 'junegunn/fzf'
  Plug 'git@github.com:ianhomer/fzf.vim.git', { 'branch' : 'fix/maps-comment' }
  source ~/.config/vim/fzf.vim

  " fugitive - Git integration
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'

  "
  " Style
  "
  Plug 'morhetz/gruvbox'
  Plug 'rakr/vim-one'

  if IsEnabled("nerdtree")
    " NERDTree - file explore
    Plug 'preservim/nerdtree'
    source ~/.config/vim/nerdtree.vim
  endif

endif

if g:config_level > 3

  "
  " Window and file management
  "
  if IsEnabled("nerdtree") | Plug 'ryanoasis/vim-devicons' | endif
  " Vinegar - better file expore than NERD
  if g:config_level > 8 | Plug 'tpope/vim-vinegar' | endif
  " ack - Search files
  Plug 'mileszs/ack.vim'
  if IsEnabled("airline")
    " Airline - status bar
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
  endif
  " editorconfig - Support standard editorconfig files
  if g:config_level > 6 | Plug 'editorconfig/editorconfig-vim' | endif
  " tmux - enable C-hjkl to move to across vim and tmux panes
  Plug 'christoomey/vim-tmux-navigator'
  " Improved path support
  Plug 'tpope/vim-apathy'
  " Indent line
  Plug 'Yggdroot/indentLine'
  " Don't switch it on by default as it can be a little brutle, rely on syntax
  " setting conceal level as desired
  let g:indentLine_setConceal = 0
  let g:indentLine_char = '┊'

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

  if IsEnabled("syntastic")
    Plug 'vim-syntastic/syntastic'
    let g:vim_jsx_pretty_colorful_config = 1
    Plug 'yuezk/vim-js'
    Plug 'maxmellon/vim-jsx-pretty'
    source ~/.config/vim/syntastic.vim
  endif

  if IsEnabled("ale")
    Plug 'dense-analysis/ale'
    source ~/.config/vim/ale.vim
  endif

  " polyglot
  nnoremap <silent> <leader>9p :call Toggle("polyglot")<CR>
  if IsEnabled("polyglot") | Plug 'sheerun/vim-polyglot' | endif
  " Commenter - loads maps prefixed with <leader>c <- don't use for local maps
  Plug 'preservim/nerdcommenter'

  if IsEnabled("nerdtree")
    " NERDTree - show git changes
    if g:config_level > 8 | Plug 'xuyuanp/nerdtree-git-plugin' | endif
  endif

  if IsEnabled("gitgutter")
    " gitgutter - Git change indicator to left of window
    Plug 'airblade/vim-gitgutter'
    let g:gitgutter_map_keys = 0
    let g:gitgutter_highlight_linenrs = 1
  endif

  " HTML
  if g:config_level > 8 | Plug 'mattn/emmet-vim' | endif
  " Handy mappings
  Plug 'tpope/vim-unimpaired'

  "
  " Writing
  "
  " goyo - Distraction free writing
  Plug 'junegunn/goyo.vim'
  " markdown preview
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
  let g:mkdp_auto_close = 0
  let g:mkdp_page_title = '${name}'
endif

" CoC completion
if IsEnabled("coc")
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

"
" Command remapping
"
source ~/.config/vim/modes.vim

" My shortcuts
if g:config_level > 0
  nnoremap <silent> <leader><space> :Buffers<CR>
  nnoremap <silent> <leader>f :Files<CR>
  nnoremap <silent> <leader>F :Files!<CR>

  " save all files
  if !IsEnabled("autosave") | nnoremap <silent> <leader>w :silent! wall<CR> | endif

  " reset things
  nnoremap <silent> <leader>z :noh<CR>

  " Hide all windows except the current one
  nnoremap <silent> <leader>O :only<CR>

  source ~/.config/vim/window-cleaner.vim

  " Start / stop profiling
  nnoremap <leader>.p :profile start ~/vim-performance.log<CR>:profile func*<CR>:profile file *<CR>
  nnoremap <leader>.o :profile stop<CR>
  nnoremap <leader>.i :profile dump<CR>

  if g:config_level > 2
    nnoremap <silent> <leader>y :BCommits<CR>
    nnoremap <silent> <leader>Y :BCommits!<CR>
    nnoremap <silent> <leader>t :Commits<CR>
    nnoremap <silent> <leader>T :Commits!<CR>
    nnoremap <silent> <leader>h :History<CR>
    nnoremap <silent> <leader>r :reg<CR>
    nnoremap <silent> <leader>k :call ToggleQuickFix()<CR>
    nnoremap <silent> <leader>K :call ToggleLocationList()<CR>
    nnoremap <silent> <leader>g :call ToggleFugitive()<CR>
    nnoremap <silent> <leader>b :call GitPush()<CR>

    if g:config_level > 3
      nnoremap <silent> <localleader> :<c-u>WhichKey  '\\'<CR>
      nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
      nnoremap <silent> <leader>p :MarkdownPreview<CR>
      nnoremap <silent> <leader>.m :!mind-map %:p<CR>
    endif
  endif

  nnoremap <silent> <leader>l :call LintMe()<CR>
  nnoremap <leader>.e <C-W><C-=>
endif

if exists('*which_key#register')
  " Note that this currently when config reloaded after which keys as been used
  " since which keys is lazily loaded
  let g:which_key_map =  {}
  let g:which_key_map.c = { 'name' : '...Commenter' }
  let g:which_key_map.j = { 'name' : '...Thingity' }
  let g:which_key_map['k'] = { 'name' : '...Bookmarks' }
  let g:which_key_map['9'] = { 'name' : '...Toggle' }
  let g:which_key_map[','] = { 'name' : '...Misc' }
  let g:which_key_map['.'] = { 'name' : '...Experimental' }
  call which_key#register('<Space>', "g:which_key_map")
endif

source ~/.config/vim/thingity.vim

function! GitPush()
  call CloseFugitiveWindow()
  Git -P push -v
endfunction

function! ToggleFugitive()
  if !CloseFugitiveWindow()
    Gstatus
  endif
endfunction

function! LintMe()
  echo "Linting ..".&filetype
  if &filetype == "markdown"
    call LintMarkdown()
  elseif IsEnabled("coc")
    " Lint
    Format
  elseif IsEnabled("ale")
    ALEFix
  elseif &filetype == "json"
    execute "%!jq ."
  endif
endfunction

function! ToggleQuickFix()
  let l:currentWindow = winnr('$')
  cwindow
  let l:quickFixWindow = winnr('$')
  if l:currentWindow == l:quickFixWindow
    cclose
  endif
endfunction

function! ToggleLocationList()
  let l:currentWindow = winnr('$')
  lwindow
  let l:locationListWindow = winnr('$')
  if l:currentWindow == l:locationListWindow
    lclose
  endif
endfunction

source ~/.config/vim/tabcomplete.vim

" Reload vimrc, neo vimrc and CoC
let g:config_file = has('nvim') ? "~/.config/nvim/init.vim" : "~/.vimrc"
let g:reload_config = "source ".g:config_file
if !exists("*ReloadConfig")
  function! ReloadConfig()
    silent! wall
    exec g:reload_config
    call RestartConfig()
    let config_message = has('nvim') ? "neo init.vm" : ".vimrc"
    let coc_message = IsEnabled("coc") ? " with CoC" : ""
    if IsNotEnabled("coc")
      " only display message if CoC not enabled, it it is enabled, this extra
      " message causes overload in the 2 row command window
      echo "Reloaded ".config_message.coc_message" - level = ".g:config_level
    endif
  endfunction
endif

if IsEnabled("coc")
  source ~/.config/vim/coc.vim
endif

function! RestartConfig()
  if IsEnabled("coc")
    CocRestart
  endif
endfunction

nnoremap <silent> <leader>v :call ReloadConfig()<CR>

" Clear whitespace
function! PruneWhiteSpace()
  %s/\s\+$//ge
  call ReduceBlankLines()
endfunction

function! ReduceBlankLines()
  call TrimEndLines()
  v/\S/,//-j
endfunction

function! TrimEndLines()
  silent! %s#\($\n\s*\)\+\%$##
endfunction

if g:config_level > 2
  nnoremap <leader>L ma:call PruneWhiteSpace()<CR>`a
endif

" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

" *** Scope : Writing ***

" Goyo distraction free writing
if g:config_level > 3
  nnoremap <leader>jg :Goyo<CR>
  let g:goyo_width = 85
endif

"
" *** Scope : Windows ***
"
if g:config_level < 2
  " Thanks - https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
  " Close the current buffer and move to the previous one
  nnoremap <leader>q :<c-u>bp <bar> bd #<cr>
endif

function! s:DebouncedSave() abort
  call timer_stop( s:debouncedSaveTimer )
  let s:debouncedSaveTimer = timer_start(1000, { timerId -> execute('write') })
endf

"
" Group all autocmds together to improve reloadability (reloads of vimrc
" replace, not add to, existing commands) and source tacking (we know that
" the autocmds came from here).
"
augroup dotme
  autocmd!

  if g:config_level > 0
    autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
  endif

  if g:config_level > 2
    "
    " *** Scope : Editing ***
    "
    " Do not highlight current line when in insert mode
    autocmd InsertEnter,InsertLeave * set cul!
  endif

  if IsEnabled("autosave")
    "
    " *** Scope : IO ***
    "
    " Auto reload when focus gained or buffer entered
    autocmd FocusGained,WinEnter,BufEnter * :checktime

    " Auto write when text changes using debouncing for insert mode
    " to wait for pause in text entry
    autocmd TextChangedI,TextChangedP * ++nested silent! call s:DebouncedSave()
    autocmd TextChanged * ++nested silent! write
  endif

  if g:config_level > 2
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
if g:config_level > 0
  exec "set listchars=tab:>~,nbsp:~,trail:\uB7"
  set list

  " Add operator af for all file
  onoremap af :<C-u>normal! ggVG<CR>

  " Return to visual mode after indenting
  vnoremap < <gv
  vnoremap > >gv
endif

source ~/.config/vim/spell.vim

" Surround customisation
if g:config_level > 2
  let g:surround_{char2nr('b')} = "**\r**"
  let g:surround_{char2nr('<')} = "<\r>"
endif

" *** Scope : IO ***
"
if g:config_level > 0
  if IsEnabled("autosave")
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
endif

" Optimise for faster terminal connections
" set ttyfast

"
" *** Scope : Status Bar ***
"

if g:config_level > 3
  " Less accurate highlighting, but improved performance
  let g:airline_highlighting_cache = 1
  " Enable tab line
  let g:airline#extensions#tabline#enabled = 1
  " Enable powerfonts giving angled tab
  let g:airline_powerline_fonts = 1
endif

" Backspace support
if g:config_level > 0
  set backspace=indent,eol,start
endif

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

if IsEnabled("nerdtree")
  let NERDTreeMinimalUI = 1
  let NERDTreeDirArrows = 1
  let NERDTreeAutoDeleteBuffer = 1
endif

if g:config_level > 0
  if IsEnabled("dark")
    colorscheme gruvbox
    set bg=dark
  else
    " Light scheme primarily used for writing content
    colorscheme one
    set bg=light
    let g:one_allow_italics = 1
    call one#highlight('Normal', '0c0c0c', '', 'none')
    call one#highlight('markdownH1', '000', '', 'bold')
    call one#highlight('markdownH2', '000', '', 'bold')
  endif
endif

if g:config_level > 2
  " Thanks to Damian Conway                                                         test long line
  set colorcolumn=""
  highlight ColorColumn ctermbg=magenta
  call matchadd('ColorColumn', '\%82v', 100)
endif

" Open new splits to the right and below
if g:config_level > 0
  set splitright
  set splitbelow
endif

source ~/.config/vim/terminal.vim

"
" *** Scope : Markdown ***
"

" Surround Customisations
" This doesn't work for me -
" https://stackoverflow.com/questions/32769488/double-vim-surround-with
" autocmd Filetype markdown let b:surround_43 = "**\r**"

" Don't conceal any syntax
set conceallevel=0

if g:config_level > 3
  " Markdown syntax
  " Enable folding
  let g:markdown_folding = 1
  " Default large fold level start, folding everything up by default feels odd.
  set foldlevelstart=20
endif

if g:config_level > 8
  source ~/.config/vim/experimental.vim
endif
