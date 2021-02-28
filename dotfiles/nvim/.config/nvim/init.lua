vim.cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias
paq {'savq/paq-nvim', opt = true}

paq 'morhetz/gruvbox'
paq 'lifepillar/vim-gruvbox8'
paq 'junegunn/fzf'
paq 'junegunn/fzf.vim'
paq 'tpope/vim-fugitive'
paq 'tpope/vim-rhubarb'
paq 'preservim/nerdtree'
paq 'mhinz/vim-startify'

paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'nvim-lua/diagnostic-nvim'
paq 'tweekmonster/startuptime.vim'

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

scopes["o"]["runtimepath"] = scopes["o"]["runtimepath"] .. ",~/.vim"



