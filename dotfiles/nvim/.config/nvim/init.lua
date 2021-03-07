local cmd = vim.cmd

cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias
local o = vim.o

o['runtimepath'] = o['runtimepath'] .. ',~/.vim'

local knobs = require('knobs')

cmd 'call knobs#Init()'

paq {'savq/paq-nvim', opt = true}

knobs.paq('light', 'rakr/vim-one')
knobs.paq('gruvbox', 'morhetz/gruvbox')
knobs.paq('gruvbox8', 'lifepillar/vim-gruvbox8')

knobs.paq('lightbulb', 'kosayoda/nvim-lightbulb')

knobs.paq('fzf', 'junegunn/fzf')
knobs.paq('fzf', 'junegunn/fzf.vim')
knobs.paq('fugitive', 'tpope/vim-fugitive')
knobs.paq('fugitive', 'tpope/vim-rhubarb')
knobs.paq('gitgutter', 'airblade/vim-gitgutter')
knobs.paq('dispatch', 'tpope/vim-dispatch')
knobs.paq('nerdtree', 'preservim/nerdtree')
knobs.paq('startify', 'mhinz/vim-startify')
knobs.paq('which_key', 'liuchengxu/vim-which-key')

knobs.paq('airline', 'vim-airline/vim-airline')
knobs.paq('airline', 'vim-airline/vim-airline-themes')
knobs.paq('gutentags', 'ludovicchabant/vim-gutentags')
knobs.paq('tabular', 'godlygeek/tabular')

paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'nvim-lua/diagnostic-nvim'

paq{'iamcco/markdown-preview.nvim', run='cd app && yarn install'}

paq 'christoomey/vim-tmux-navigator'

knobs.paq('startuptime', 'tweekmonster/startuptime.vim')

knobs.paq('nerdtree', 'ryanoasis/vim-devicons')
knobs.paq('minimap', 'wfxr/minimap.vim')

knobs.paq('ale', 'dense-analysis/ale')

require('lsp')

