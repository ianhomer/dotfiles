local cmd = vim.cmd
local o = vim.o

cmd 'packadd packer.nvim'            -- load the package manager

return require('packer').startup(function(use)
  o['runtimepath'] = o['runtimepath'] .. ',~/.vim'

  local useif = require('knobs').useif(use)
  cmd 'call knobs#Init()'

  use 'wbthomason/packer.nvim'

  use {'rakr/vim-one'}
  use {'morhetz/gruvbox', opt = false}

  use {'lifepillar/gruvbox8', opt = false}

  use {'kosayoda/nvim-lightbulb'}
  use {'onsails/lspkind-nvim'}

  use {'junegunn/fzf'}
  use {'junegunn/fzf.vim'}
  use {'tpope/vim-fugitive', cmd = {'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull'}}

  use {'tpope/vim-rhubarb'}
  useif {'airblade/vim-gitgutter'}
  useif {'tpope/vim-dispatch'}
  use {'preservim/nerdtree', cmd={'NERDTreeFind', 'NERDTreeToggle'}}
  useif {'mhinz/vim-startify'}

  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  cmd "let g:gutentags_cache_dir = expand('~/.cache/tags')"

  use {'ludovicchabant/vim-gutentags'}
  use {'godlygeek/tabular', cmd={'Tabularize'}}

  use {'junegunn/goyo.vim'}
  use {'tpope/vim-surround'}

  use 'neovim/nvim-lspconfig'
  useif {'hrsh7th/nvim-compe',
    config = function() require('compe-init').setup() end
  }

  use {'iamcco/markdown-preview.nvim', run='cd app && yarn install'}

  use 'christoomey/vim-tmux-navigator'

  -- use {'dstein64/vim-startuptime'}
  use {'tweekmonster/startuptime.vim'}

  useif {'ryanoasis/vim-devicons'}
  use {'wfxr/minimap.vim', cmd={"Minimap"}}

  use {'dense-analysis/ale', cmd={"ALEFix"}}
  use {'liuchengxu/vim-which-key'}

  require('lsp')
  require('lspkind').init()
  require('lualine').setup{{theme = 'gruvbox'}}
end)
