local cmd = vim.cmd
local o = vim.o

cmd 'packadd packer.nvim'            -- load the package manager

return require('packer').startup(function(use)
  o['runtimepath'] = o['runtimepath'] .. ',~/.vim'

  local knobs = require('knobs')
  cmd 'call knobs#Init()'

  knobs.setUse(use)
  use 'wbthomason/packer.nvim'

  use {'rakr/vim-one'}
  use {'morhetz/gruvbox', opt = false}

  use {'lifepillar/gruvbox8', opt = false}

  use {'kosayoda/nvim-lightbulb'}

  use {'junegunn/fzf'}
  use {'junegunn/fzf.vim'}
  use {'tpope/vim-fugitive'}

  use {'tpope/vim-rhubarb'}
  use {'airblade/vim-gitgutter'}
  use {'tpope/vim-dispatch'}
  use {'preservim/nerdtree', cmd={'NERDTreeFind'}}
  use {'mhinz/vim-startify'}

  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- use {'vim-airline/vim-airline'}
  -- use {'vim-airline/vim-airline-themes'}

  cmd "let g:gutentags_cache_dir = expand('~/.cache/tags')"

  use {'ludovicchabant/vim-gutentags'}
  use {'godlygeek/tabular'}

  use {'junegunn/goyo.vim'}
  use {'tpope/vim-surround'}

  use 'neovim/nvim-lspconfig'
  -- paq 'nvim-lua/completion-nvim'

  use {'iamcco/markdown-preview.nvim', run='cd app && yarn install'}

  use 'christoomey/vim-tmux-navigator'

  -- use {'dstein64/vim-startuptime'}
  use {'tweekmonster/startuptime.vim'}

  use {'ryanoasis/vim-devicons'}
  use {'wfxr/minimap.vim'}

  use {'dense-analysis/ale'}
  use {'liuchengxu/vim-which-key'}

  require('lsp')
  require('lualine').setup{{theme = 'gruvbox'}}
end)
