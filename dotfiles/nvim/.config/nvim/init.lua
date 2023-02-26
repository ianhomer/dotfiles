local g = vim.g
local o = vim.o
local nvim_set_var = vim.api.nvim_set_var

vim.opt.shell = "/bin/bash"

local impatientOk, _ = pcall(require, "impatient")
if impatientOk then
  _.enable_profile()
end

require("config/core")

nvim_set_var("knobs_default_level", 3)

-- Levels at which knobs are enabled
nvim_set_var("knobs_levels", {
  abolish = 5,
  apathy = 6,
  autopairs = 3,
  autosave = 3,
  barbar = 5,
  bqf = 5,
  codewindow = 6,
  colorizer = 4,
  conflict_marker = 7,
  commentary = 4,
  compactcmd = 3,
  cmp = 3,
  dap = 6,
  defaults = 3,
  devicons = 3,
  dispatch = 3,
  document_color = 9,
  easy_align = 3,
  editorconfig = 9,
  endwise = 7,
  eunuch = 3,
  fidget = 3,
  flog = 9,
  fugitive = 3,
  friendly_snippets = 3,
  fzf = 6,
  git_conflict = 9,
  gitgutter = 6,
  gitsigns = 5,
  gruvbox = 9,
  gruvbox8 = 9,
  glow = 5,
  goyo = 9,
  gv = 9,
  icon_picker = 5,
  indent_blankline = 5,
  indentline = 5,
  kanagawa = 3,
  lens = 8,
  lightbulb = 3,
  lightspeed = 3,
  lsp = 3,
  lsp_colors = 9,
  lspconfig = 3,
  lspkind = 3,
  lsp_signature = 3,
  lspsaga = 9,
  lualine = 3,
  luasnip = 3,
  markdown_syntax_table = 3,
  markdown_preview = 3,
  minimap = 9,
  modes = 3,
  mundo = 3,
  neoscroll = 3,
  neotest = 9,
  noice = 9,
  notify = 5,
  null_ls = 3,
  nvim_tree = 3,
  rainbow = 3,
  refactoring = 9,
  vim_repeat = 3,
  rhubarb = 7,
  schemastore = 3,
  shortcuts = 3,
  sleuth = 9,
  spelling = 3,
  startify = 4,
  startuptime = 3,
  surround = 3,
  symbols_outline = 9,
  tabular = 3,
  telescope = 3,
  telescope_fzf_native = 3,
  telescope_symbols = 3,
  test = 6,
  thingity = 3,
  toggleterm = 3,
  treesitter = 3,
  treesitter_textobjects = 6,
  treesitter_context = 6,
  trouble = 3,
  ufo = 3,
  unicode = 9,
  unimpaired = 4,
  update_spelling = 7,
  which_key = 3,
  window_cleaner = 3,
  writegood = 3,
  vimspector = 9,
  vsnip = 9,
  zen_mode = 5,
})

-- Feature toggles triggered by each layer
nvim_set_var("knobs_layers_map", {
  debug = {
    debug = 1,
  },
  mobile = {
    compactcmd = 1,
    light = 1,
    markdown_flow = 1,
    markdown_conceal_full = 1,
    markdown_syntax_list = 1,
  },
})

g.indentLine_enabled = 1
g.indent_blankline_char = "▏"

g.indent_blankline_filetype_exclude = { "help", "startify", "terminal" }
g.indent_blankline_buftype_exclude = { "terminal" }

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false

require("config.kitty")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_set_keymap("n", "<space>i", "<cmd>:ZenMode<CR>", {})

local knobspath = vim.fn.stdpath("data") .. "/knobs/knobs.vim"
if not vim.loop.fs_stat(knobspath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/ianhomer/knobs.vim.git",
    "--branch=main",
    knobspath,
  })
end
vim.opt.rtp:prepend(knobspath)

local knobs = require("knobs")
knobs.setup()

local with_knobs = function(plugins)
  for _, plugin in ipairs(plugins) do
    if plugin.cond == nil then
      local knob = plugin.knob or knobs.fromPackage(plugin[1])
      local level = vim.g["knobs_levels"][knob]
      if level then
        plugin.cond = vim.g["knob_" .. knob] or false
      end
    end
  end
  return plugins
end

require("config.config")

require("lazy").setup(
  with_knobs({
    {
      "b0o/schemastore.nvim",
    },

    -- LSP, autocomplete and code guidance
    {
      "neovim/nvim-lspconfig",
      event = "BufWinEnter",
      config = function()
        require("config.lspconfig")
      end,
    },
    {
      "weilbith/nvim-code-action-menu",
      cmd = "CodeActionMenu",
    },
    {
      "onsails/lspkind-nvim",
      config = function()
        require("lspkind").init()
      end,
    },
    -- {
    --   "glepnir/lspsaga.nvim",
    --   event = "BufWinEnter",
    --   config = function()
    --     require("config.lspsaga")
    --   end,
    -- },
    {
      "saadparwaiz1/cmp_luasnip",
      knob = "luasnip"
    },
    {
      "L3MON4D3/LuaSnip",
      dependencies = { "saadparwaiz1/cmp_luasnip" },
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp-signature-help",
      },
      config = function()
        require("config.cmp")
      end,
    },
    -- {
    --   "j-hui/fidget.nvim",
    --   config = [[require'fidget'.setup{}]],
    -- },
    {
      "kosayoda/nvim-lightbulb",
      config = function()
        require("config.lightbulb")
      end,
    },
    {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require("config.null_ls")
      end,
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- {
    --   cmd = "Vista",
    --   "liuchengxu/vista.vim",
    -- },
    -- {
    --   "rcarriga/nvim-notify",
    --   config = [[require'config.notify']],
    -- },
    -- {
    --   "folke/noice.nvim",
    --   event = "VimEnter",
    --   config = [[require'config.noice']],
    --   cond = vim.g.knob_noice,
    --   dependencies = {
    --     "MunifTanjim/nui.nvim",
    --     "rcarriga/nvim-notify",
    --   },
    -- },
    {
      "folke/trouble.nvim",
      dependencies = "kyazdani42/nvim-web-devicons",
      cmd = "Trouble",
      config = function()
        require("config.trouble")
      end,
    },
    -- {
    --   "kevinhwang91/nvim-bqf",
    --   ft = "qf",
    --   config = [[require'config.bqf']],
    -- },
    -- {
    --   "majutsushi/tagbar",
    --   cmd = "TagbarToggle",
    --   config = [[require'config.tagbar']],
    -- },
    -- {
    --   "folke/lsp-colors.nvim",
    -- },
    {
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      config = function()
        require("config.treesitter")
      end,
      build = ":TSUpdate",
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      config = function()
        require("config.treesitter_textobjects")
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("config.treesitter_context")
      end,
    },
    -- {
    --   "vim-test/vim-test",
    -- },
    -- {
    --   cond = vim.g.knob_neotest,
    --   "nvim-neotest/neotest-vim-test",
    -- },
    -- {
    --   "nvim-neotest/neotest",
    --   requires = {
    --     "nvim-lua/plenary.nvim",
    --     "nvim-treesitter/nvim-treesitter",
    --     "antoinemadec/FixCursorHold.nvim",
    --     "vim-test/vim-test",
    --     "nvim-neotest/neotest-vim-test",
    --   },
    --   config = [[require'config.neotest']],
    -- },
    -- {
    --   cond = vim.g.knob_dap,
    --   "nvim-telescope/telescope-dap.nvim",
    -- },
    -- {
    --   "mfussenegger/nvim-dap",
    --   config = [[require'config.dap']],
    -- },
    -- {
    --   cond = vim.g.knob_dap,
    --   "rcarriga/nvim-dap-ui",
    --   requires = "mfussenegger/nvim-dap",
    --   config = [[require'config.dapui']],
    -- },
    -- {
    --   "puremourning/vimspector",
    --   config = [[require'config.vimspector']],
    -- },
    -- {
    --   "ThePrimeagen/refactoring.nvim",
    --   config = [[require'config.refactoring']],
    --   requires = {
    --     { "nvim-lua/plenary.nvim" },
    --     { "nvim-treesitter/nvim-treesitter" },
    --   },
    -- },
    -- {
    --   "simrat39/symbols-outline.nvim",
    --   setup = [[require'config.symbols_outline']],
    -- },

    -- -- Navigation

    {
      "mhinz/vim-startify",
    },
    -- {
    --   "junegunn/fzf.vim",
    --   cmd = { "Ag", "Buffers", "Commits", "Files", "History" },
    --   fn = { "fzf#vim#ag" },
    --   ft = { "qf" },
    -- },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    {
      "nvim-telescope/telescope-symbols.nvim",
      knob = "telescope",
    },
    -- {
    --   "nvim-lua/popup.nvim",
    -- },
    {
      "nvim-telescope/telescope.nvim",
      knob = "telescope",
      dependencies = {
        { "rebelot/kanagawa.nvim" },
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim" },
        { "nvim-telescope/telescope-symbols.nvim" },
      },
      config = function()
        require("config.telescope")
      end,
    },
    {
      "kyazdani42/nvim-tree.lua",
      dependencies = "kyazdani42/nvim-web-devicons",
      config = function()
        require("config.nvimtree")
      end,
      cmd = { "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle" },
    },
    {
      "ryanoasis/vim-devicons",
      lazy = true,
    },
    {
      "wfxr/minimap.vim",
      cmd = { "Minimap" },
    },
    -- {
    --   "gorbit99/codewindow.nvim",
    --   config = [[require'config.codewindow']],
    -- },
    {
      "folke/which-key.nvim",
      event = "BufWinEnter",
      config = function()
        require("config.which_key")
      end,
    },
    -- {
    --   "ggandor/lightspeed.nvim",
    -- },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("config.lualine")
      end,
    },
    {
      "romgrk/barbar.nvim",
      dependencies = { "kyazdani42/nvim-web-devicons" },
      cmd = "BarbarEnable",
      config = function()
        require("config.barbar")
      end,
    },

    -- -- Style
    {
      "rebelot/kanagawa.nvim",
      config = function()
        require("config.kanagawa")
      end,
    },
    -- {
    --   "NvChad/nvim-colorizer.lua",
    --   config = [[require'config.colorizer']],
    --   event = "BufRead",
    -- },
    -- {
    --   "mrshmllow/document-color.nvim",
    --   config = [[require'config.document_color']],
    -- },
    {
      "karb94/neoscroll.nvim",
      config = function()
        require("config.neoscroll")
      end,
    },
    {
      "p00f/nvim-ts-rainbow",
      knob = "rainbow",
      dependencies = "nvim-treesitter",
      config = function()
        require("config.rainbow")
      end,
    },
    {
      "kevinhwang91/nvim-ufo",
      dependencies = "kevinhwang91/promise-async",
      config = function()
        require("config.ufo")
      end,
    },

    -- -- Git
    {
      "tpope/vim-fugitive",
      cmd = { "G", "Git", "Gstatus", "Gblame", "Ggrep", "Gpush", "Gpull" },
    },
    -- {
    --   "rbong/vim-flog",
    -- },
    -- {
    --   "tpope/vim-rhubarb",
    --   cmd = { "GBrowse" },
    -- },
    {
      "airblade/vim-gitgutter",
    },
    -- {
    --   "akinsho/git-conflict.nvim",
    --   config = [[require'config.git_conflict']],
    -- },
    {
      "tpope/vim-dispatch",
    },
    {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = function()
        require("config.gitsigns")
      end,
    },
    -- {
    --   "junegunn/gv.vim",
    --   cmd = { "GV" },
    -- },
    -- -- Editing
    {
      "windwp/nvim-autopairs",
      dependencies = "nvim-cmp",
      config = [[require'config.autopairs']],
    },
    {
      "tpope/vim-surround",
    },
    -- {
    --   "tpope/vim-sleuth",
    -- },
    {
      "tpope/vim-commentary",
    },
    -- {
    --   "tpope/vim-unimpaired",
    -- },
    {
      "tpope/vim-repeat",
      knob = "vim_repeat"
    },
    -- {
    --   "tpope/vim-abolish",
    -- },
    -- {
    --   "stevearc/dressing.nvim",
    -- },
    -- {
    --   "ziontee113/icon-picker.nvim",
    --   config = [[require'config.icon_picker']],
    --   dependencies = "dressing.nvim",
    -- },
    {
      "godlygeek/tabular",
      cmd = { "Tabularize" },
    },
    -- {
    --   "editorconfig/editorconfig-vim",
    -- },
    -- {
    --   "chrisbra/unicode.vim",
    -- },

    -- {
    --   "folke/zen-mode.nvim",
    --   cmd = { "ZenMode" },
    --   config = [[require'config.zen_mode']],
    -- },

    -- {
    --   "junegunn/goyo.vim",
    -- },

    -- {
    --   "junegunn/vim-easy-align",
    -- },

    -- {
    --   "ellisonleao/glow.nvim",
    --   cmd = { "Glow" },
    -- },
    {
      "iamcco/markdown-preview.nvim",
      -- cmd = {"MarkdownPreview"},
      build = "cd app && yarn install",
    },
    {
      "lukas-reineke/indent-blankline.nvim",
    },
    {
      "simnalamburt/vim-mundo",
      cmd = { "MundoToggle" },
    },

    -- -- Misc

    {
      "akinsho/toggleterm.nvim",
      cmd = { "ToggleTerm", "TermExec" },
      config = function()
        require("config.toggleterm")
      end,
    },
    {
      "tpope/vim-eunuch",
    },

    -- -- Diagnostics

    {
      "tweekmonster/startuptime.vim",
    },
  }),
  {
    ui = {
      size = { width = 1.0, height = 1.0 },
    },
    performance = {
      rtp = {
        paths = {
          os.getenv("HOME") .. "/.vim",
          knobspath,
        },
      },
    },
  }
)
