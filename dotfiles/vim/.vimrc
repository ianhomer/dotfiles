if !knobs#At(1)
  finish
endif

" Load plugins
call plug#begin(knobs#GetPluggedDir())
"
" Core essentials
"
" fzf - Fuzzy Finder
if knobs#could("fzf")
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
endif

" fugitive - Git integration
if knobs#could("fugitive")
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
endif

IfKnob 'conflict-marker' Plug 'rhysd/conflict-marker.vim'

"
" Style
"
IfKnob 'light' Plug 'rakr/vim-one'

IfKnob 'gruvbox'  Plug 'morhetz/gruvbox'
IfKnob 'gruvbox8' Plug 'lifepillar/vim-gruvbox8'

"
" Trying chadtree, if better than nerdtree then
" nerdtree will be removed
"
if knobs#could("chadtree") && has('nvim')
  Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
endif

IfKnob 'nerdtree' Plug 'preservim/nerdtree'
IfKnob 'nnn' Plug 'mcchrish/nnn.vim'
IfKnob 'nerdtree' Plug 'ryanoasis/vim-devicons'
IfKnob 'minimap' Plug 'wfxr/minimap.vim'

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
IfKnob 'lens' Plug 'camspiers/lens.vim'

IfKnob 'gutentags' Plug 'ludovicchabant/vim-gutentags'

"
" Help
"
" vim-which-key - guidance on what keys do
if knobs#could("which_key")
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

if knobs#could("syntastic")
  Plug 'vim-syntastic/syntastic'
  Plug 'yuezk/vim-js'
  Plug 'maxmellon/vim-jsx-pretty'
endif

IfKnob 'ale' Plug 'dense-analysis/ale'

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

" gitgutter - Git change indicator to left of window
IfKnob 'gitgutter' Plug 'airblade/vim-gitgutter'

" HTML
if KnobAt(9) | Plug 'mattn/emmet-vim' | endif
" Handy mappings
IfKnob 'unimpaired' Plug 'tpope/vim-unimpaired'

"
" Writing
"
" goyo - Distraction free writing
if KnobAt(5) | Plug 'junegunn/goyo.vim' | endif

if KnobAt(5)
  " markdown preview
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
endif

" Vim testing
if KnobAt(6) | Plug 'junegunn/vader.vim' | endif

IfKnob 'startuptime' Plug 'tweekmonster/startuptime.vim'

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
  lua require'lspconfig'.cssls.setup{}
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

