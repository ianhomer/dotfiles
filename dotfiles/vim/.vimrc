if has('nvim')
  " Store nvim plugins in isolated location
  let g:vim_dir = "~/.config/nvim"
else
  let g:vim_dir = "~/.vim"
endif

" Default values for knobs
let g:knobs_defaults = {
  \   "compactcmd":0,
  \   "markdown.flow":0,
  \   "markdown.conceal.full":0,
  \   "markdown.conceal.partial":0,
  \   "markdown.syntax.list":0,
  \   "markdown.syntax.table":1,
  \   "polyglot":0,
  \   "syntastic":0,
  \   "startuptime":0
  \ }

" Levels at which knobs are enabled
let g:knobs_levels = {
  \   "ale":5,
  \   "apathy":5,
  \   "airline":5,
  \   "autosave":5,
  \   "chadtree":5,
  \   "conflict-marker":7,
  \   "dispatch":5,
  \   "endwise":5,
  \   "eunuch":5,
  \   "fugitive":5,
  \   "fzf":4,
  \   "gitgutter":5,
  \   "gruvbox":5,
  \   "gruvbox8":1,
  \   "goyo":5,
  \   "gutentags":5,
  \   "nerdtree":4,
  \   "minimap": 5,
  \   "modes":1,
  \   "nnn":6,
  \   "polyglot":5,
  \   "spelling":5,
  \   "startify":4,
  \   "startuptime":5,
  \   "surround":5,
  \   "tabcomplete":5,
  \   "tabular":5,
  \   "thingity":5,
  \   "unimpaired":5,
  \   "update-spelling":5,
  \   "which-key":7,
  \   "window-cleaner":5,
  \   "writegood":8
  \ }

" Feature toggles triggered by each layer
let g:knobs_layers_map = {
  \    "mobile":{
  \      "compactcmd":1,
  \      "light":1,
  \      "markdown.flow":1,
  \      "markdown.conceal.full":1,
  \      "markdown.syntax.list":1
  \    },
  \    "notes":{
  \      "compactcmd":1,
  \      "light":1,
  \      "markdown.conceal.partial":1
  \    },
  \    "nvim-0.5":{
  \      "lsp":1
  \    }
  \  }

" Default state of layers
" iTerm used for notes layer
let g:knobs_layers = get(g:, "layers",{
  \   "mobile": $ANDROID_DATA == '/data' ? 1 : 0,
  \   "notes": $ITERM_PROFILE == 'oh-my' ? 1 : 0,
  \   "nvim-0.5": has('nvim-0.5') ? 1 : 0
  \ })

"
" CORE Configuration - START
"
let mapleader = "\<Space>"
let maplocalleader = "\\"

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
" Highelight dynamically as pattern is typed
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
" Tab support with 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
" 80 characters default width
set textwidth=80
" Softbreak on space between words
set linebreak
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" I don't use modelines
set nomodeline

"
" CORE Configuration - END
"

if !knobs#At(1)
  finish
endif
if !knobs#("nerdtree")
  nnoremap <silent> <leader>f :call knobs#core#SetLevel(5)<CR>
  nnoremap <silent> <leader>n :call knobs#core#SetLevel(5)<CR>
  nnoremap <silent> <leader>s :call knobs#core#SetLevel(5)<CR>
endif

" Provide more space for command output (e.g. fugitive) - with it this you may
" need to press ENTER after fugitive commands
if knobs#("compactcmd")
  set cmdheight=1
else
  set cmdheight=2
endif

" Start / stop profiling
nnoremap <leader>.p :profile start ~/vim-performance.log<CR>:profile func*<CR>:profile file *<CR>
nnoremap <leader>.o :profile stop<CR>
nnoremap <leader>.i :profile dump<CR>

" save all files
if !knobs#("autosave") | nnoremap <silent> <leader>w :silent! wall<CR> | endif

" reset highlighting
nnoremap <silent> <leader>z :noh<CR>

if knobs#("modes")
  " Numbered modes of configuration
  nnoremap <silent> <leader>1 :call modes#ResetMode()<CR>
  nnoremap <silent> <leader>2 :call modes#PersonalDevMode()<CR>
  nnoremap <silent> <leader>3 :call modes#MobbingMode()<CR>
  nnoremap <silent> <leader>4 :call modes#TrainingMode()<CR>
endif

" Quit and save/close are handy leaders for use on mobile and limited keyboard
nnoremap <silent> <leader>q :call window#cleaner#CloseMe()<CR>
nnoremap <silent> <leader>x :x<CR>
" I don't use macros, q to quit is more convenient for me
nnoremap <silent> q :call window#cleaner#CloseMe()<CR>


" why?
"filetype plugin on
"filetype plugin off

" Load plugins
call plug#begin(g:vim_dir."/plugged")
"
" Core essentials
"
" fzf - Fuzzy Finder
if knobs#could("fzf")
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  source ~/.config/vim/fzf.vim
endif

" fugitive - Git integration
if knobs#could("fugitive")
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
endif

if knobs#could("conflict-marker")
  Plug 'rhysd/conflict-marker.vim'
  autocmd ColorScheme * highlight Info gui=bold guifg=#504945 guibg=#83a598
  let g:conflict_marker_highlight_group="Info"
endif

"
" Style
"
if knobs#could("light")
  Plug 'rakr/vim-one'
endif

IfKnob 'gruvbox'  Plug 'morhetz/gruvbox'
IfKnob 'gruvbox8' Plug 'lifepillar/vim-gruvbox8'

"
" Trying chadtree, if better than nerdtree then
" nerdtree will be removed
"
if knobs#could("chadtree")
  Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
  source ~/.config/vim/chadtree.vim
endif

if knobs#could("nerdtree")
  " NERDTree - file explore
  Plug 'preservim/nerdtree'
  source ~/.config/vim/nerdtree.vim
endif

if knobs#could("nnn")
  "
  " Window and file management
  "
  Plug 'mcchrish/nnn.vim'
  let g:nnn#set_default_mappings = 0
  let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6  } }
  nnoremap <silent> <leader>m :NnnPicker<CR>
endif

IfKnob 'nerdtree' Plug 'ryanoasis/vim-devicons'
IfKnob 'minimap' Plug 'wfxr/minimap.vim'
let g:minimap_auto_start = 1

" Vinegar - better file expore than NERD
if KnobAt(9) | Plug 'tpope/vim-vinegar' | endif
" ack - Search files
if KnobAt(6) | Plug 'mileszs/ack.vim' | endif
if knobs#could("airline")
  " Airline - status bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
endif
" editorconfig - Support standard editorconfig files
if KnobAt(7) | Plug 'editorconfig/editorconfig-vim' | endif
" tmux - enable C-hjkl to move to across vim and tmux panes
Plug 'christoomey/vim-tmux-navigator'
" Improved path support
IfKnob 'apathy' Plug 'tpope/vim-apathy'
" UNIX-like shell commands
IfKnob 'eunuch' Plug 'tpope/vim-eunuch'

IfKnob 'startify' Plug 'mhinz/vim-startify'

if knobs#could("gutentags")
  Plug 'ludovicchabant/vim-gutentags' 
  let g:gutentags_cache_dir = expand('~/.cache/tags')
endif

"
" Help
"
" vim-which-key - guidance on what keys do
if knobs#could("which-key")
  Plug 'liuchengxu/vim-which-key',
  \ { 'on': ['WhichKey', 'WhichKey!'] }
endif

"
" Coding
"

" tabular - Lining up columns
IfKnob 'tabular' Plug 'godlygeek/tabular'
" symlink - Follow symlink when opening file
Plug 'aymericbeaumet/vim-symlink'
" surround - Surround with brackets etc
IfKnob 'surround' Plug 'tpope/vim-surround'
" repeat - Repeat with mapped commands with . not just the native command
Plug 'tpope/vim-repeat'
" endwise - auto close structure
IfKnob 'endwise' Plug 'tpope/vim-endwise'
" Aysynchronous
if knobs#could("dispatch")
  Plug 'tpope/vim-dispatch'
  let g:dispatch_no_tmux_make = 1
  let g:dispatch_quickfix_height = 4
endif

if knobs#could("syntastic")
  Plug 'vim-syntastic/syntastic'
  let g:vim_jsx_pretty_colorful_config = 1
  Plug 'yuezk/vim-js'
  Plug 'maxmellon/vim-jsx-pretty'
  source ~/.config/vim/syntastic.vim
endif

if knobs#could("ale")
  Plug 'dense-analysis/ale'
  source ~/.config/vim/ale.vim
endif

" polyglot
if knobs#could("polyglot")
  let g:polyglot_disabled = ['markdown']
  Plug 'sheerun/vim-polyglot'
  Plug 'aliou/bats.vim'
endif

" Commenter - loads maps prefixed with <leader>c <- don't use for local maps
if KnobAt(5) | Plug 'preservim/nerdcommenter' | endif

if knobs#could("nerdtree")
  " NERDTree - show git changes
  if KnobAt(9) | Plug 'xuyuanp/nerdtree-git-plugin' | endif
endif

if knobs#could("gitgutter")
  " gitgutter - Git change indicator to left of window
  Plug 'airblade/vim-gitgutter'
  let g:gitgutter_map_keys = 0
  let g:gitgutter_highlight_linenrs = 1
endif

" HTML
if KnobAt(9) | Plug 'mattn/emmet-vim' | endif
" Handy mappings
if Knob("unimpaired")
  Plug 'tpope/vim-unimpaired'
endif

"
" Writing
"
" goyo - Distraction free writing
if KnobAt(5) | Plug 'junegunn/goyo.vim' | endif

if KnobAt(5)
  " markdown preview
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
  let g:mkdp_auto_close = 0
  let g:mkdp_page_title = '${name}'
endif

" Vim testing
if KnobAt(6) | Plug 'junegunn/vader.vim' | endif

if knobs#could("startuptime")
  Plug 'tweekmonster/startuptime.vim'
endif

if knobs#("lsp")
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-lua/diagnostic-nvim'
endif

" CoC completion
if knobs#could("coc")
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

call plug#end()

if knobs#("lsp")
  lua require'lspconfig'.bashls.setup{}
  lua require'lspconfig'.jsonls.setup{}
  lua require'lspconfig'.pyls.setup{}
  lua require'lspconfig'.tsserver.setup{}
  lua require'lspconfig'.vimls.setup{}
  lua require'lspconfig'.yamlls.setup{}
  
  autocmd BufEnter * lua require'completion'.on_attach()

  " Set completeopt to have a better completion experience
  set completeopt=menuone,noinsert,noselect

  let g:completion_chain_complete_list = {
    \ 'default': [
    \    {'complete_items': ['lsp', 'snippet' ]},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \]
  \}
  let g:completion_tabnine_priority = 0
  imap <c-p> <Plug>(completion_trigger)
  set omnifunc=v:lua.vim.lsp.omnifunc

  "nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
  nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
  nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
endif

if !Knob("light")
  if knobs#("gruvbox")
    colorscheme gruvbox
  elseif knobs#("gruvbox8")
    colorscheme gruvbox8
  endif
  set bg=dark
else
  " Light scheme primarily used for writing content
  colorscheme one
  set bg=light
  let $BG_MODE="light"
  let g:one_allow_italics = 1
  call one#highlight('Normal', '000000', 'ffffff', 'none')
  for i in [1,2,3,4,5,6]
    call one#highlight('markdownH'.i, '000000', 'ffffff', 'bold')
  endfor
  call one#highlight('markdownH2', '000000', 'ffffff', 'bold')
  call one#highlight('Directory', '222222', '', 'bold')
  highlight Cursor guibg=grey
  highlight iCursor guibg=black
  set guicursor=n-v-c:block-Cursor
  set guicursor+=i:ver100-iCursor
endif

if !KnobAt(3)
  finish
endif

if Knob("startify")
  let g:startify_custom_header = ""
  let g:startify_session_autoload = 0
  let g:startify_change_to_dir = 0
  let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('my#gitModified'),  'header': ['   git modified']},
        \ { 'type': function('my#gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ { 'type': function('my#nerdtreeBookmarks'),
        \ 'header': ['   NERDTree Bookmarks']}
        \ ]
endif

" My shortcuts
if KnobAt(1)
  nnoremap <silent> <leader><space> :Buffers<CR>
  nnoremap <silent> <leader>f :call my#SearchFiles()<CR>
  nnoremap <silent> <leader>F :Files!<CR>

  " Hide all windows except the current one
  nnoremap <silent> <leader>O :only<CR>

  if KnobAt(3)
    nnoremap <silent> <leader>y :BCommits<CR>
    nnoremap <silent> <leader>Y :BCommits!<CR>
    nnoremap <silent> <leader>t :Commits<CR>
    nnoremap <silent> <leader>T :Commits!<CR>
    nnoremap <silent> <leader>h :History<CR>
    nnoremap <silent> <leader>r :reg<CR>
    nnoremap <silent> <leader>k :call my#ToggleQuickFix()<CR>
    nnoremap <silent> <leader>K :call my#ToggleLocationList()<CR>
    nnoremap <silent> <leader>g :call window#ToggleFugitive()<CR>
    nnoremap <silent> <leader>gd :Gvdiff!<CR>
    nnoremap gdh :diffget //2<CR>
    nnoremap gdl :diffget //3<CR>
    nnoremap <silent> <leader>b :call my#GitSynk(1)<CR>
    nnoremap <silent> <leader>e :call my#GitSynk(0)<CR>

    " ... and let this q mapping apply for NERDTree
    let NERDTreeMapQuit='qq'

    "nnoremap <silent> q :echo "q disabled"<CR>

    if KnobAt(4)
      if knobs#("which-key")
        nnoremap <silent> <localleader> :<c-u>WhichKey  '\\'<CR>
        nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
      endif
      nnoremap <silent> <leader>p :MarkdownPreview<CR>
      nnoremap <silent> <leader>.m :!mind-map %:p<CR>
    endif
  endif

  nnoremap <silent> <leader>l :call my#LintMe()<CR>
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
  call which_key#register("'", "g:which_key_map")
endif

if knobs#("thingity")
  source ~/.config/vim/thingity.vim
endif

if knobs#("tabcomplete")
  source ~/.config/vim/tabcomplete.vim
endif

if knobs#("coc")
  source ~/.config/vim/coc.vim
endif

if KnobAt(3)
  nnoremap <leader>L ma:call my#PruneWhiteSpace()<CR>`a
endif

" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

" *** Scope : Writing ***

" Goyo distraction free writing
if knobs#("goyo")
  nnoremap <leader>jg :Goyo<CR>
  let g:goyo_width = 85
endif

"
" *** Scope : Windows ***
"
"
" Group all autocmds together to improve reloadability (reloads of vimrc
" replace, not add to, existing commands) and source tacking (we know that
" the autocmds came from here).
"
augroup dotme
  autocmd!

  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

  if KnobAt(3)
    "
    " *** Scope : Editing ***
    "
    " Do not highlight current line when in insert mode
    autocmd InsertEnter,InsertLeave * set cul!
  endif

  if knobs#("autosave")
    "
    " *** Scope : IO ***
    "
    " Auto reload when focus gained or buffer entered
    autocmd FocusGained,WinEnter,BufEnter * :checktime

    " Auto write when text changes using debouncing to wait for pause in text
    " entry. If we save too often then tools that watch for change will get too
    " busy.
    autocmd TextChangedI,TextChangedP * ++nested silent!
      \ call my#DebouncedSave(3000)
    autocmd InsertLeave,TextChanged * ++nested silent! call my#DebouncedSave(500)
  endif

  if KnobAt(3)
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
if KnobAt(1)
  exec "set listchars=tab:>~,nbsp:~,trail:\uB7"
  set list

  " Add operator af for all file
  onoremap af :<C-u>normal! ggVG<CR>

  " Return to visual mode after indenting
  vnoremap < <gv
  vnoremap > >gv
endif

if knobs#("spelling")
  source ~/.config/vim/spell.vim
endif

" Surround customisation
if KnobAt(3)
  let g:surround_{char2nr('b')} = "**\r**"
  let g:surround_{char2nr('<')} = "<\r>"
  " Short cuts for surround word
  if knobs#("which-key")
    nnoremap <silent> ' :WhichKey "'"<CR>
  endif
  nmap '" ysiW"
  nmap "" ysiW"
  nmap '' ysiW'
  nmap '` ysiW`
  nmap '< ysiW<
  nmap 'b ysiWb
endif

" *** Scope : IO ***
"
if KnobAt(1)
  if knobs#("autosave")
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

if knobs#("airline")
  " Less accurate highlighting, but improved performance
  let g:airline_highlighting_cache = 1
  " Explicit airline extensions for quicker start up
  let g:airline_extensions = [
         \ "ale",
         \ "branch",
         \ "tabline",
         \ "whitespace",
         \ "wordcount"
         \ ]
  " Enable powerfonts giving angled tab
  let g:airline_powerline_fonts = 1
  let g:airline_skip_empty_sections = 1
  let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
  let g:airline_detect_spell = 0
endif

" Backspace support
if KnobAt(1)
  set backspace=indent,eol,start
endif

" source ~/.config/vim/netrw.vim

if KnobAt(3)
  " Thanks to Damian Conway                                                         test long line
  set colorcolumn=""
  highlight ColorColumn ctermbg=magenta
  call matchadd('ColorColumn', '\%82v', 100)
endif

" Open new splits to the right and below
set splitright
set splitbelow

source ~/.config/vim/terminal.vim

" Surround Customisations
" This doesn't work for me -
" https://stackoverflow.com/questions/32769488/double-vim-surround-with
" autocmd Filetype markdown let b:surround_43 = "**\r**"

" Don't conceal any syntax
set conceallevel=0

if KnobAt(4)
  " Markdown syntax
  " Enable folding
  let g:markdown_folding = 1
  " Default large fold level start, folding everything up by default feels odd.
  set foldlevelstart=20
endif

if KnobAt(9)
  source ~/.config/vim/experimental.vim
endif
