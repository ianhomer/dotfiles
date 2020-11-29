if has('nvim')
  " Store nvim plugins in isolated location
  let g:vim_dir = "~/.config/nvim"
else
  let g:vim_dir = "~/.vim"
endif

let g:knobs_default_level = 2

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
  \   "autosave":4,
  \   "conflict-marker":7,
  \   "dispatch":5,
  \   "endwise":5,
  \   "eunuch":5,
  \   "fugitive":5,
  \   "fzf":5,
  \   "gitgutter":5,
  \   "gruvbox":5,
  \   "gruvbox8":2,
  \   "goyo":5,
  \   "nerdtree":5,
  \   "modes":5,
  \   "nnn":6,
  \   "spelling":5,
  \   "startify":5,
  \   "startuptime":5,
  \   "surround":5,
  \   "tabcomplete":5,
  \   "tabular":5,
  \   "thingity":5,
  \   "unimpaired":5,
  \   "update-spelling":5,
  \   "which-key":5,
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
  \    }
  \  }

" Default state of layers
" iTerm used for notes layer
let g:knobs_layers = get(g:, "layers",{
  \   "mobile": $ANDROID_DATA == '/data' ? 1 : 0,
  \   "notes": $ITERM_PROFILE == 'oh-my' ? 1 : 0
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

" Provide more space for command output (e.g. fugitive) - with it this you may
" need to press ENTER after fugitive commands
if knobs#("compactcmd")
  set cmdheight=1
else
  set cmdheight=2
endif

" why?
"filetype plugin on
"filetype plugin off

" Load plugins
call plug#begin(g:vim_dir."/plugged")
"
" Core essentials
"
" fzf - Fuzzy Finder
if knobs#("fzf")
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  source ~/.config/vim/fzf.vim
endif

" fugitive - Git integration
if knobs#("fugitive")
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
endif

if knobs#("conflict-marker")
  Plug 'rhysd/conflict-marker.vim'
  autocmd ColorScheme * highlight Info gui=bold guifg=#504945 guibg=#83a598
  let g:conflict_marker_highlight_group="Info"
endif

"
" Style
"
if knobs#("light")
  Plug 'rakr/vim-one'
endif

IfKnob 'gruvbox'  Plug 'morhetz/gruvbox'
IfKnob 'gruvbox8' Plug 'lifepillar/vim-gruvbox8'

if Knob("nerdtree")
  " NERDTree - file explore
  Plug 'preservim/nerdtree'
  source ~/.config/vim/nerdtree.vim
endif

if KnobAt(4)

  if Knob("nnn")
    "
    " Window and file management
    "
    Plug 'mcchrish/nnn.vim'
    let g:nnn#set_default_mappings = 0
    let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6  } }
    nnoremap <silent> <leader>m :NnnPicker<CR>
  endif

  IfKnob 'nerdtree' Plug 'ryanoasis/vim-devicons'
  " Vinegar - better file expore than NERD
  if KnobAt(9) | Plug 'tpope/vim-vinegar' | endif
  " ack - Search files
  if KnobAt(6) | Plug 'mileszs/ack.vim' | endif
  if Knob("airline")
    " Airline - status bar
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
  endif
  " editorconfig - Support standard editorconfig files
  if KnobAt(7) | Plug 'editorconfig/editorconfig-vim' | endif
  " tmux - enable C-hjkl to move to across vim and tmux panes
  Plug 'christoomey/vim-tmux-navigator'
  " Improved path support
  if Knob("apathy") | Plug 'tpope/vim-apathy' | endif
  " UNIX-like shell commands
  if Knob("eunuch") | Plug 'tpope/vim-eunuch' | endif

  IfKnob 'startify' Plug 'mhinz/vim-startify'

  if KnobAt(5)
    Plug 'ludovicchabant/vim-gutentags'
    let g:gutentags_cache_dir = expand('~/.cache/tags')
  endif

  "
  " Help
  "
  " vim-which-key - guidance on what keys do
  if Knob("which-key")
    Plug 'liuchengxu/vim-which-key', 
    \ { 'on': ['WhichKey', 'WhichKey!'] }
  endif

  "
  " Coding
  "

  " tabular - Lining up columns
  if Knob("tabular") | Plug 'godlygeek/tabular' | endif
  " symlink - Follow symlink when opening file
  Plug 'aymericbeaumet/vim-symlink'
  " surround - Surround with brackets etc
  if Knob("surround") | Plug 'tpope/vim-surround' | endif
  " repeat - Repeat with mapped commands with . not just the native command
  Plug 'tpope/vim-repeat'
  " endwise - auto close structure
  if Knob("endwise") | Plug 'tpope/vim-endwise' | endif
  " Aysynchronous
  if Knob("dispatch")
    Plug 'tpope/vim-dispatch'
    let g:dispatch_no_tmux_make = 1
    let g:dispatch_quickfix_height = 4
  endif

  if Knob("syntastic")
    Plug 'vim-syntastic/syntastic'
    let g:vim_jsx_pretty_colorful_config = 1
    Plug 'yuezk/vim-js'
    Plug 'maxmellon/vim-jsx-pretty'
    source ~/.config/vim/syntastic.vim
  endif

  if Knob("ale")
    Plug 'dense-analysis/ale'
    source ~/.config/vim/ale.vim
  endif

  " polyglot
  nnoremap <silent> <leader>9p :call Toggle("polyglot")<CR>
  if Knob("polyglot") | Plug 'sheerun/vim-polyglot' | endif
  " Commenter - loads maps prefixed with <leader>c <- don't use for local maps
  if KnobAt(5) | Plug 'preservim/nerdcommenter' | endif

  if Knob("nerdtree")
    " NERDTree - show git changes
    if KnobAt(9) | Plug 'xuyuanp/nerdtree-git-plugin' | endif
  endif

  if Knob("gitgutter")
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

endif

if Knob("startuptime")
  Plug 'tweekmonster/startuptime.vim'
endif

" CoC completion
if Knob("coc")
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

call plug#end()

if !Knob("light")
  if Knob("gruvbox")
    colorscheme gruvbox
  elseif Knob("gruvbox8")
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

function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" Read ~/.NERDTreeBookmarks file and takes its second column
function! s:nerdtreeBookmarks()
  let bookmarks = systemlist("cut -d' ' -f 2 ~/.NERDTreeBookmarks")
  let bookmarks = bookmarks[0:-2] " Slices an empty last line
  return map(bookmarks, "{'line': v:val, 'path': v:val}")
endfunction

if Knob("startify")
  let g:startify_custom_header = ""
  let g:startify_session_autoload = 0
  let g:startify_change_to_dir = 0
  let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ { 'type': function('s:nerdtreeBookmarks'), 'header': ['   NERDTree Bookmarks']}
        \ ]
endif

"
" Command remapping
"
if Knob("modes") 
  source ~/.config/vim/modes.vim
endif

" My shortcuts
if KnobAt(1)
  nnoremap <silent> <leader><space> :Buffers<CR>
  nnoremap <silent> <leader>f :call SearchFiles()<CR>
  nnoremap <silent> <leader>F :Files!<CR>

  " save all files
  if !Knob("autosave") | nnoremap <silent> <leader>w :silent! wall<CR> | endif

  " reset things
  nnoremap <silent> <leader>z :noh<CR>

  " Hide all windows except the current one
  nnoremap <silent> <leader>O :only<CR>

  if Knob("window-cleaner")
    source ~/.config/vim/window-cleaner.vim
  endif

  " Start / stop profiling
  nnoremap <leader>.p :profile start ~/vim-performance.log<CR>:profile func*<CR>:profile file *<CR>
  nnoremap <leader>.o :profile stop<CR>
  nnoremap <leader>.i :profile dump<CR>

  if KnobAt(3)
    nnoremap <silent> <leader>y :BCommits<CR>
    nnoremap <silent> <leader>Y :BCommits!<CR>
    nnoremap <silent> <leader>t :Commits<CR>
    nnoremap <silent> <leader>T :Commits!<CR>
    nnoremap <silent> <leader>h :History<CR>
    nnoremap <silent> <leader>r :reg<CR>
    nnoremap <silent> <leader>k :call ToggleQuickFix()<CR>
    nnoremap <silent> <leader>K :call ToggleLocationList()<CR>
    nnoremap <silent> <leader>g :call ToggleFugitive()<CR>
    nnoremap <silent> <leader>gd :Gvdiff!<CR>
    nnoremap gdh :diffget //2<CR>
    nnoremap gdl :diffget //3<CR>
    nnoremap <silent> <leader>b :call GitSynk(1)<CR>
    nnoremap <silent> <leader>e :call GitSynk(0)<CR>

    " Quit and save/close are handy leaders for use on mobile and limited keyboard
    nnoremap <silent> <leader>q :call CloseMe()<CR>
    nnoremap <silent> <leader>x :x<CR>
    " I don't use macros, q to quit is more convenient for me
    nnoremap <silent> q :call CloseMe()<CR>
    " ... and let this q mapping apply for NERDTree
    let NERDTreeMapQuit='qq'

    "nnoremap <silent> q :echo "q disabled"<CR>

    if KnobAt(4)
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
  call which_key#register("'", "g:which_key_map")
endif

if Knob("thingity")
  source ~/.config/vim/thingity.vim
endif

function! SearchFiles() 
  call SwitchToFirstEditableFile()
  Files
endfunction

function! GitSynk(onlyPush)
  call CloseFugitiveWindow()
  if a:onlyPush || !Knob("dispatch")
    Gpush
  else
    Dispatch! Git synk
  endif
endfunction

function! CloseMe()
  if &filetype == "startify" || winnr('$') > 1
    quit
  elseif &filetype == "nerdtree" && winnr('$') > 1
    NERDTreeClose
  else
    if exists('*Startify')
      execute ":Startify"
    endif
    call CloseAllBuffersButCurrent()
  endif
endfunction

function! ToggleFugitive()
  if !CloseFugitiveWindow()
    Gstatus
  endif
endfunction

function! LintMe()
  echo "Linted ".&filetype
  if &filetype == "markdown"
    call LintMarkdown()
  elseif Knob("coc")
    " Lint
    Format
  elseif Knob("ale")
    ALEFix
  elseif &filetype == "json"
    execute "%!jq ."
  else
    normal ma
    call PruneWhiteSpace()
    normal `a
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

if Knob("tabcomplete")
  source ~/.config/vim/tabcomplete.vim
endif

if Knob("coc")
  source ~/.config/vim/coc.vim
endif

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

if KnobAt(3)
  nnoremap <leader>L ma:call PruneWhiteSpace()<CR>`a
endif

" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

" *** Scope : Writing ***

" Goyo distraction free writing
if Knob("goyo")
  nnoremap <leader>jg :Goyo<CR>
  let g:goyo_width = 85
endif

"
" *** Scope : Windows ***
"
if KnobAt(3)
  " Thanks - https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
  " Close the current buffer and move to the previous one
  nnoremap <leader>q :<c-u>bp <bar> bd #<cr>
endif

function! s:DebouncedSave() abort
  if &buftype == "" && @% != ""
    call timer_stop( s:debouncedSaveTimer )
    let s:debouncedSaveTimer = timer_start(1000, { timerId -> execute('write') })
  endif
endf

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

  if Knob("autosave")
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

if Knob("spelling")
  source ~/.config/vim/spell.vim
endif

" Surround customisation
if KnobAt(3)
  let g:surround_{char2nr('b')} = "**\r**"
  let g:surround_{char2nr('<')} = "<\r>"
  " Short cuts for surround word
  nnoremap <silent> ' :WhichKey "'"<CR>
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
  if Knob("autosave")
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

if Knob("airline")
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

" vnoremap <s-tab> <<
" nnoremap <tab> >>
" vnoremap <tab> >>

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
