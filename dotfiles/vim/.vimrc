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
  Plug 'junegunn/fzf.vim'
  source ~/.config/vim/fzf.vim

  " fugitive - Git integration
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'rhysd/conflict-marker.vim'
  autocmd ColorScheme * highlight Info gui=bold guifg=#504945 guibg=#83a598
  let g:conflict_marker_highlight_group="Info"

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

if g:config_level > 3

  "
  " Window and file management
  "
  Plug 'mcchrish/nnn.vim'
  let g:nnn#set_default_mappings = 0
  let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6  } }
  nnoremap <silent> <leader>m :NnnPicker<CR>

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
  " UNIX-like shell commands
  Plug 'tpope/vim-eunuch'

  Plug 'mhinz/vim-startify'
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

  Plug 'ludovicchabant/vim-gutentags'
  let g:gutentags_cache_dir = expand('~/.cache/tags')

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
  " Aysynchronous
  Plug 'tpope/vim-dispatch'
  let g:dispatch_no_tmux_make = 1
  let g:dispatch_quickfix_height = 4

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

  " Vim testing
  Plug 'junegunn/vader.vim'
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
" Provide more space for command output (e.g. fugitive) - with it this you may
" need to press ENTER after fugitive commands
if IsEnabled("compactcmd")
  set cmdheight=1
else
  set cmdheight=2
endif
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
" Command remapping
"
source ~/.config/vim/modes.vim

" My shortcuts
if g:config_level > 0
  nnoremap <silent> <leader><space> :Buffers<CR>
  nnoremap <silent> <leader>f :call SearchFiles()<CR>
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
  call which_key#register("'", "g:which_key_map")
endif

source ~/.config/vim/thingity.vim

function! SearchFiles() 
  call SwitchToFirstEditableFile()
  Files
endfunction

function! GitSynk(onlyPush)
  call CloseFugitiveWindow()
  if a:onlyPush
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
    execute ":Startify"
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
  elseif IsEnabled("coc")
    " Lint
    Format
  elseif IsEnabled("ale")
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
    if expand('%:p') != ""
      normal ma
      " Reload current buffer
      silent edit
      normal `a
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
  if &buftype == ""
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
if g:config_level > 0
  set backspace=indent,eol,start
endif

" vnoremap <s-tab> <<
" nnoremap <tab> >>
" vnoremap <tab> >>

" source ~/.config/vim/netrw.vim

if g:config_level > 0
  if !IsEnabled("light")
    colorscheme gruvbox
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
