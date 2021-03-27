local cmd = vim.cmd
local o = vim.o

cmd 'packadd packer.nvim'            -- load the package manager

return require('packer').startup(function(use)
  o['runtimepath'] = o['runtimepath'] .. ',~/.vim'

  local knobs = require('knobs')
  cmd 'call knobs#Init()'

  knobs.setUse(use)
  use 'wbthomason/packer.nvim'

  knobs.use {'rakr/vim-one', 'light'}
  knobs.use {'morhetz/gruvbox', opt = false}

  knobs.use {'lifepillar/gruvbox8', opt = false}

  use {'kosayoda/nvim-lightbulb'}

  knobs.use {'junegunn/fzf'}
  knobs.use {'junegunn/fzf.vim'}
  use {'tpope/vim-fugitive'}

  knobs.use {'tpope/vim-rhubarb', 'fugitive'}
  knobs.use {'airblade/vim-gitgutter'}
  knobs.use {'tpope/vim-dispatch'}
  knobs.use {'preservim/nerdtree'}
  knobs.use {'mhinz/vim-startify'}

  knobs.use {'vim-airline/vim-airline'}
  knobs.use {'vim-airline/vim-airline-themes', 'airline'}

  cmd "let g:gutentags_cache_dir = expand('~/.cache/tags')"

  knobs.use {'ludovicchabant/vim-gutentags'}
  knobs.use {'godlygeek/tabular'}

  knobs.use {'junegunn/goyo.vim'}
  knobs.use {'tpope/vim-surround'}

  use 'neovim/nvim-lspconfig'
  -- paq 'nvim-lua/completion-nvim'

  use {'iamcco/markdown-preview.nvim', run='cd app && yarn install'}

  use 'christoomey/vim-tmux-navigator'

  knobs.use {'tweekmonster/startuptime.vim'}

  use {'ryanoasis/vim-devicons'}
  knobs.use {'wfxr/minimap.vim'}

  knobs.use {'dense-analysis/ale'}

  knobs.use {'liuchengxu/vim-which-key', 'which_key'}

  require('lsp')
end)
