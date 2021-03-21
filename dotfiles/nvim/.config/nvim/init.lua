local cmd = vim.cmd
local o = vim.o

cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias

o['runtimepath'] = o['runtimepath'] .. ',~/.vim'

local knobs = require('knobs')

cmd 'call knobs#Init()'

paq {'savq/paq-nvim', opt = true}

knobs.paq {'rakr/vim-one', 'light'}
knobs.paq {'morhetz/gruvbox'}

knobs.paq {'lifepillar/gruvbox8'}

paq {'kosayoda/nvim-lightbulb'}

knobs.paq {'junegunn/fzf'}
knobs.paq {'junegunn/fzf.vim'}
paq {'tpope/vim-fugitive'}

knobs.paq {'tpope/vim-rhubarb', 'fugitive'}
knobs.paq {'airblade/vim-gitgutter'}
knobs.paq {'tpope/vim-dispatch'}
knobs.paq {'preservim/nerdtree'}
knobs.paq {'mhinz/vim-startify'}
knobs.paq {'liuchengxu/vim-which-key', 'which_key'}

knobs.paq {'vim-airline/vim-airline'}
knobs.paq {'vim-airline/vim-airline-themes', 'airline'}

cmd "let g:gutentags_cache_dir = expand('~/.cache/tags')"

knobs.paq {'ludovicchabant/vim-gutentags'}
knobs.paq {'godlygeek/tabular'}

knobs.paq {'junegunn/goyo.vim'}
knobs.paq {'tpope/vim-surround'}

paq 'neovim/nvim-lspconfig'
-- paq 'nvim-lua/completion-nvim'

paq {'iamcco/markdown-preview.nvim', run='cd app && yarn install'}

paq 'christoomey/vim-tmux-navigator'

knobs.paq {'tweekmonster/startuptime.vim'}

paq {'ryanoasis/vim-devicons'}
knobs.paq {'wfxr/minimap.vim'}

knobs.paq {'dense-analysis/ale'}

knobs.paq {'liuchengxu/vim-which-key', 'which_key'}

require('lsp')
