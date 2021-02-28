local cmd = vim.cmd

cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias
local o = vim.o

o["runtimepath"] = o["runtimepath"] .. ",~/.vim"

local knobs = require("knobs")

cmd 'call knobs#Init()'

paq {'savq/paq-nvim', opt = true}

if knobs.has('gruvbox') then
  paq 'morhetz/gruvbox'
elseif knobs.has('gruvbox8') then
  paq 'lifepillar/vim-gruvbox8'
end

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

if knobs.has('ale') then
  paq 'dense-analysis/ale'
end
