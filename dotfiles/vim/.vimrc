"
" See init.lua for more recent configuration
"

let g:init_vim = 1

" Default values for knobs
let g:knobs_defaults = {
  \   "markdown_syntax_table":1
  \ }

" Levels at which knobs are enabled
let g:knobs_levels = {
  \   "ale":4,
  \   "apathy":5,
  \   "airline":5,
  \   "autosave":3,
  \   "conflict_marker":7,
  \   "devicons":5,
  \   "defaults":1,
  \   "dispatch":5,
  \   "endwise":5,
  \   "eunuch":5,
  \   "fugitive":3,
  \   "fzf":1,
  \   "gitgutter":5,
  \   "gruvbox":3,
  \   "gruvbox8":1,
  \   "goyo":4,
  \   "gutentags":5,
  \   "lens":8,
  \   "minimap": 5,
  \   "modes":1,
  \   "nerdtree":1,
  \   "spelling":4,
  \   "startify":1,
  \   "startuptime":2,
  \   "surround":4,
  \   "tabcomplete":4,
  \   "tabular":4,
  \   "thingity":4,
  \   "unimpaired":4,
  \   "update_spelling":6,
  \   "which_key":5,
  \   "window_cleaner":4,
  \   "writegood":8
  \ }

" Feature toggles triggered by each layer
let g:knobs_layers_map = {
  \    "mobile":{
  \      "compactcmd":1,
  \      "markdown_flow":1,
  \      "markdown_conceal_full":1,
  \      "markdown_syntax_list":1
  \    }
  \  }

if !knobs#At(1)
  finish
endif

" Load plugins
call plug#begin(knobs#GetPluggedDir())
"
" Core essentials
"
" fzf - Fuzzy Finder
if knobs#plug#If("fzf")
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
endif

" fugitive - Git integration
if knobs#plug#If("fugitive")
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
endif

IfKnob 'conflict-marker' Plug 'rhysd/conflict-marker.vim'

"
" Style
"
IfKnob 'gruvbox'  Plug 'morhetz/gruvbox'
IfKnob 'gruvbox8' Plug 'lifepillar/vim-gruvbox8'

IfKnob 'nerdtree' Plug 'preservim/nerdtree'
IfKnob 'nerdtree' Plug 'ryanoasis/vim-devicons'
IfKnob 'minimap' Plug 'wfxr/minimap.vim'

" Vinegar - better file expore than NERD
if knobs#At(9) | Plug 'tpope/vim-vinegar' | endif
" ack - Search files
if knobs#At(6) | Plug 'mileszs/ack.vim' | endif
if knobs#plug#If("airline")
  " Airline - status bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
endif
" editorconfig - Support standard editorconfig files
if knobs#At(7) | Plug 'editorconfig/editorconfig-vim' | endif
" tmux - enable C-hjkl to move to across vim and tmux panes
Plug 'christoomey/vim-tmux-navigator'
" Improved path support
IfKnob 'apathy' Plug 'tpope/vim-apathy'
" UNIX-like shell commands
IfKnob 'eunuch' Plug 'tpope/vim-eunuch'

IfKnob 'startify' Plug 'mhinz/vim-startify'
IfKnob 'lens' Plug 'camspiers/lens.vim'

IfKnob 'gutentags' Plug 'ludovicchabant/vim-gutentags'

"
" Help
"
" vim-which-key - guidance on what keys do
if knobs#plug#If("which_key")
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
IfKnob 'dispatch' Plug 'tpope/vim-dispatch'

IfKnob 'ale' Plug 'dense-analysis/ale'

" Commenter - loads maps prefixed with <leader>c <- don't use for local maps
if knobs#At(5) | Plug 'preservim/nerdcommenter' | endif

if knobs#plug#If("nerdtree")
  " NERDTree - show git changes
  if knobs#At(9) | Plug 'xuyuanp/nerdtree-git-plugin' | endif
endif

" gitgutter - Git change indicator to left of window
IfKnob 'gitgutter' Plug 'airblade/vim-gitgutter'

" HTML
if knobs#At(9) | Plug 'mattn/emmet-vim' | endif
" Handy mappings
IfKnob 'unimpaired' Plug 'tpope/vim-unimpaired'

"
" Writing
"
" goyo - Distraction free writing
if knobs#At(5) | Plug 'junegunn/goyo.vim' | endif

if knobs#At(5)
  " markdown preview
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
endif

" Vim testing
if knobs#At(6) | Plug 'junegunn/vader.vim' | endif

IfKnob 'startuptime' Plug 'tweekmonster/startuptime.vim'

call plug#end()
