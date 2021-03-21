local cmd = vim.cmd
local o = vim.o

cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias

o['runtimepath'] = o['runtimepath'] .. ',~/.vim'

local knobs = require('knobs')

cmd 'call knobs#Init()'

paq {'savq/paq-nvim', opt = true}

knobs.paq1('light', 'rakr/vim-one')
knobs.paq1('gruvbox', 'morhetz/gruvbox')

knobs.paq1('gruvbox8', 'lifepillar/vim-gruvbox8')

knobs.paq1('lightbulb', 'kosayoda/nvim-lightbulb')

knobs.paq {'junegunn/fzf'}
knobs.paq {'junegunn/fzf.vim'}
knobs.paq1('fugitive', 'tpope/vim-fugitive')
knobs.paq1('fugitive', 'tpope/vim-rhubarb')
knobs.paq1('gitgutter', 'airblade/vim-gitgutter')
knobs.paq1('dispatch', 'tpope/vim-dispatch')
knobs.paq1('nerdtree', 'preservim/nerdtree')
knobs.paq1('startify', 'mhinz/vim-startify')
knobs.paq1('which_key', 'liuchengxu/vim-which-key')

knobs.paq1('airline', 'vim-airline/vim-airline')
knobs.paq1('airline', 'vim-airline/vim-airline-themes')

cmd "let g:gutentags_cache_dir = expand('~/.cache/tags')"

knobs.paq1('gutentags', 'ludovicchabant/vim-gutentags')
knobs.paq1('tabular', 'godlygeek/tabular')

knobs.paq1('goyo', 'junegunn/goyo.vim')
knobs.paq1('surround', 'tpope/vim-surround')

paq 'neovim/nvim-lspconfig'
-- paq 'nvim-lua/completion-nvim'

paq{'iamcco/markdown-preview.nvim', run='cd app && yarn install'}

paq 'christoomey/vim-tmux-navigator'

knobs.paq1('startuptime', 'tweekmonster/startuptime.vim')

knobs.paq1('nerdtree', 'ryanoasis/vim-devicons')
knobs.paq1('minimap', 'wfxr/minimap.vim')

knobs.paq1('ale', 'dense-analysis/ale')

knobs.paq1('which_key', 'liuchengxu/vim-which-key')

require('lsp')
