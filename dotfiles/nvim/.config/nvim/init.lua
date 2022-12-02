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
  ale = 9,
  apathy = 6,
  airline = 9,
  autopairs = 3,
  autosave = 3,
  barbar = 5,
  bqf = 5,
  codewindow = 5,
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
  hop = 6, -- alternative to lightspeed
  icon_picker = 5,
  indent_blankline = 5,
  indentline = 5,
  kanagawa = 3,
  nerdtree = 9,
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
  markdown_preview = 9,
  minimap = 9,
  modes = 3,
  mundo = 3,
  neoscroll = 3,
  neotest = 9,
  noice = 9,
  nnn = 9,
  notify = 5,
  null_ls = 3,
  nvim_tree = 3,
  peek = 5,
  peekaboo = 9,
  rainbow = 3,
  refactoring = 9,
  rhubarb = 7,
  shortcuts = 3,
  sleuth = 9,
  spelling = 3,
  startify = 4,
  startuptime = 3,
  surround = 3,
  symbols_outline = 9,
  tabcomplete = 9,
  tabular = 3,
  telescope = 3,
  telescope_fzf_native = 3,
  telescope_symbols = 3,
  telekasten = 9,
  test = 5,
  thingity = 3,
  tmux_navigator = 9,
  toggleterm = 3,
  tpipeline = 9,
  treesitter = 3,
  trouble = 3,
  twightlight = 9,
  ufo = 9,
  unicode = 9,
  unimpaired = 4,
  update_spelling = 7,
  which_key = 3,
  window_cleaner = 9,
  writegood = 3,
  vimspector = 9,
  vsnip = 9,
  vimux = 5,
  zen_mode = 5,
  zephyr = 9,
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

return require("packer").startup({
  function(_use)
    o["runtimepath"] = o["runtimepath"] .. ",~/.vim"

    _use("lewis6991/impatient.nvim")

    local ok, knobs = pcall(require, "knobs")
    local use = ok and knobs.use(_use) or _use

    require("config.config")

    use("wbthomason/packer.nvim")
    use("ianhomer/knobs.vim")

    _use({
      "b0o/schemastore.nvim",
      commit = "867541a33274844aba13cea1b0611f6854bda851",
    })
    -- LSP, autocomplete and code guidance
    use({
      "neovim/nvim-lspconfig",
      event = "BufWinEnter",
      config = [[require'config.lspconfig']],
      commit = "90e4f3f89806a9b96d6e1c4d8112a5614aa0017e",
    })
    use({
      "weilbith/nvim-code-action-menu",
      cmd = "CodeActionMenu",
      commit = "58e12501ea028ff1171f8f06ea53891f7c6e1c3f",
    })
    _use({
      "onsails/lspkind-nvim",
      config = [[require("lspkind").init()]],
      commit = "c68b3a003483cf382428a43035079f78474cd11e",
    })

    use({
      "glepnir/lspsaga.nvim",
      event = "BufWinEnter",
      config = [[require'config.lspsaga']],
      commit = "af711c8985dfced92a5883591f221ba223841f76",
    })

    _use({
      "hrsh7th/cmp-nvim-lsp",
      commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb",
    })

    _use({
      "hrsh7th/cmp-buffer",
      commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
    })

    _use({
      "hrsh7th/cmp-path",
      commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
    })

    _use({
      "hrsh7th/cmp-cmdline",
      commit = "23c51b2a3c00f6abc4e922dbd7c3b9aca6992063",
    })

    _use({
      "hrsh7th/cmp-nvim-lua",
      commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21",
    })

    _use({
      knob = "lsp_signature",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      commit = "d2768cb1b83de649d57d967085fe73c5e01f8fd7",
    })

    -- _use({
    --     "hrsh7th/cmp-nvim-lsp-document-symbol",
    --     commit = "c3f0086ed9882e52e0ae38dd5afa915f69054941",
    -- })
    --
    -- _use({
    --     "rafamadriz/friendly-snippets",
    --     commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1",
    -- })

    _use({
      knob = "luasnip",
      "saadparwaiz1/cmp_luasnip",
      commit = "18095520391186d634a0045dacaa346291096566",
    })

    _use({
      knob = "luasnip",
      "L3MON4D3/LuaSnip",
      requires = { "saadparwaiz1/cmp_luasnip" },
      commit = "3fa5c8d938e4ed9dcfd3e07d13b587cba4f87e7d",
    })

    _use({
      "hrsh7th/nvim-cmp",
      requires = "hrsh7th/cmp-buffer",
      config = [[require'config.cmp']],
      commit = "93f385c17611039f3cc35e1399f1c0a8cf82f1fb",
      -- after = "LuaSnip",
    })

    -- _use({
    --     "petertriho/cmp-git",
    --     requires = "nvim-lua/plenary.nvim",
    --     config = [[require'config.cmp_git']],
    --     commit = "fae6cdb407ad6c63a0b1928670bad1a67a55b887",
    -- })

    -- use({
    --     knob = "vsnip",
    --     "hrsh7th/cmp-vsnip",
    --     after = "cmp-nvim-lsp",
    --     commit = "0abfa1860f5e095a07c477da940cfcb0d273b700",
    -- })

    -- use({
    --     knob = "vsnip",
    --     "hrsh7th/vim-vsnip-integ",
    --     after = "cmp-nvim-lsp",
    --     commit = "64c2ed66406c58163cf81fb5e13ac2f9fcdfb52b",
    -- })

    -- use({
    --     "hrsh7th/vim-vsnip",
    --     event = "InsertEnter",
    --     requires = {
    --         { "hrsh7th/vim-vsnip-integ", cond = "vim.g.knob_vsnip ~= nil" },
    --     },
    --     commit = "8f199ef690ed26dcbb8973d9a6760d1332449ac9",
    -- })

    use({
      "j-hui/fidget.nvim",
      commit = "44585a0c0085765195e6961c15529ba6c5a2a13b",
      config = [[require'fidget'.setup{}]],
    })

    use({
      "kosayoda/nvim-lightbulb",
      config = [[require'config.lightbulb']],
      commit = "56b9ce31ec9d09d560fe8787c0920f76bc208297",
    })

    use({
      "jose-elias-alvarez/null-ls.nvim",
      config = [[require'config.null_ls']],
      commit = "c51978f546a86a653f4a492b86313f4616412cec",
      requires = { "nvim-lua/plenary.nvim" },
    })

    use({
      cmd = "Vista",
      "liuchengxu/vista.vim",
      commit = "33774aff5d8b224f24c2e4c6015c613c1a17bf74",
    })

    use({
      "rcarriga/nvim-notify",
      config = [[require'config.notify']],
      commit = "859056ff7aec327255578c7a98ef02d0cd829f65",
    })

    use({
      "folke/noice.nvim",
      event = "VimEnter",
      config = [[require'config.noice']],
      commit = "5ca31af06078d6188de7db1369c2b40d1b606d58",
      requires = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    })

    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = [[require'config.trouble']],
      commit = "897542f90050c3230856bc6e45de58b94c700bbf",
    })
    use({
      "kevinhwang91/nvim-bqf",
      ft = "qf",
      commit = "448fa92e7f3838e3b5adbce58b55c5f97a6d2cec",
      config = [[require'config.bqf']],
    })

    use({
      "majutsushi/tagbar",
      cmd = "TagbarToggle",
      config = [[require'config.tagbar']],
      commit = "af3ce7c3cec81f2852bdb0a0651d2485fcd01214",
    })

    use({
      "folke/lsp-colors.nvim",
      commit = "4e6da1984d23da88a947805866580c48fc3cc8d7",
    })

    -- use({
    --     "dense-analysis/ale",
    --     ft = { "sh", "javascript", "markdown", "lua", "python", "typescript", "vim" },
    --     cmd = { "ALEFix" },
    --     commit = "a33960eb51b638f232dff71cfeac5ede87b38312",
    -- })

    use({
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      config = [[require'config.treesitter']],
      run = ":TSUpdate",
      commit = "4b900527045c49af5f43291d2cb13ae27a3bc7be",
    })

    use({
      knob = "treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
      config = [[require'config.treesitter_textobjects']],
      commit = "98476e7364821989ab9b500e4d20d9ae2c5f6564",
    })

    use({
      knob = "treesitter",
      "nvim-treesitter/nvim-treesitter-context",
      config = [[require'config.treesitter_context']],
      commit = "5fda0b9a2a9049ecc9900e2d86d9ddebab95b0c5",
    })

    use({
      "vim-test/vim-test",
      commit = "ab7feab8cb139e5b4955cb4c6ddf52e968cb24be",
    })
    use({
      knob = "neotest",
      "nvim-neotest/neotest-vim-test",
      commit = "c2d33f3f245fe59143fac95153945d18e5b6052b",
    })
    use({
      "nvim-neotest/neotest",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "vim-test/vim-test",
        "nvim-neotest/neotest-vim-test",
      },
      commit = "b449394aa36b05eef6719162356c2ae531460bd9",
      config = [[require'config.neotest']],
    })
    use({
      knob = "dap",
      "nvim-telescope/telescope-dap.nvim",
      commit = "b4134fff5cbaf3b876e6011212ed60646e56f060",
    })
    use({
      "mfussenegger/nvim-dap",
      config = [[require'config.dap']],
      commit = "f0573ea26f29702ad9aa1546e102adb2f5b7ac3a",
    })
    use({
      knob = "dap",
      "rcarriga/nvim-dap-ui",
      requires = "mfussenegger/nvim-dap",
      config = [[require'config.dapui']],
      commit = "54365d2eb4cb9cfab0371306c6a76c913c5a67e3",
    })
    use({
      "puremourning/vimspector",
      config = [[require'config.vimspector']],
      commit = "56f469c787c16bf3e57ab27d2d2b3f97064e7686",
    })

    use({
      "ThePrimeagen/refactoring.nvim",
      commit = "c9ca8e3bbf7218101f16e6a03b15bf72b99b2cae",
      config = [[require'config.refactoring']],
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
      },
    })

    use({
      "simrat39/symbols-outline.nvim",
      commit = "6a3ed24c5631da7a5d418bced57c16b32af7747c",
      setup = [[require'config.symbols_outline']],
    })

    -- Navigation

    use({ "mhinz/vim-startify", commit = "81e36c352a8deea54df5ec1e2f4348685569bed2" })
    use({
      "junegunn/fzf.vim",
      cmd = { "Ag", "Buffers", "Commits", "Files", "History" },
      fn = { "fzf#vim#ag" },
      ft = { "qf" },
      commit = "9ceac718026fd39498d95ff04fa04d3e40c465d7",
    })
    _use({
      "nvim-lua/plenary.nvim",
      commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7",
    })
    _use({
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      commit = "8fff2b20b2eb788b76015639352eb8ebbec87cd9",
    })

    _use({
      "nvim-telescope/telescope-symbols.nvim",
      commit = "f7d7c84873c95c7bd5682783dd66f84170231704",
    })
    _use({
      "nvim-lua/popup.nvim",
      commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac",
    })
    _use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim" },
        { "nvim-telescope/telescope-symbols.nvim" },
      },
      config = [[require'config.telescope']],
      commit = "3c2e5fb23e9f6ca1aa682ae16bac3319bfe03e38",
    })

    use({
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = [[require'config.nvimtree']],
      cmd = { "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle" },
      commit = "829e9f68e10a998198e17bf5b348a6947f9d3c2e",
    })
    _use({
      "ryanoasis/vim-devicons",
      commit = "71f239af28b7214eebb60d4ea5bd040291fb7e33",
    })
    use({
      "wfxr/minimap.vim",
      cmd = { "Minimap" },
      commit = "2b0151d7302f87f90c4664d119518dda73cc4633",
    })
    use({
      "gorbit99/codewindow.nvim",
      config = [[require'config.codewindow']],
      commit = "987b394b3c987cb9dd6c07ea57de88a4ce64f7e1",
    })
    use({
      "folke/which-key.nvim",
      event = "BufWinEnter",
      config = [[require'config.which_key']],
      commit = "61553aeb3d5ca8c11eea8be6eadf478062982ac9",
    })
    use({
      "phaazon/hop.nvim",
      config = [[require'config.hop']],
      commit = "90db1b2c61b820e230599a04fedcd2679e64bd07",
    })
    use({
      "ggandor/lightspeed.nvim",
      commit = "299eefa6a9e2d881f1194587c573dad619fdb96f",
    })

    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = [[require'config.lualine']],
      commit = "bfa0d99ba6f98d077dd91779841f1c88b7b5c165",
      after = "noice.nvim",
    })
    use({
      "romgrk/barbar.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = [[require'config.barbar']],
      commit = "9347ed838e0bfd8993d29eac1294f82b8e04c0c3",
    })

    -- Style
    use({
      "rebelot/kanagawa.nvim",
      commit = "fb733c1043a462155b52cd97efd920f1dd72d33a",
      config = [[require'config.kanagawa']],
    })
    use({
      "NvChad/nvim-colorizer.lua",
      config = [[require'config.colorizer']],
      event = "BufRead",
      commit = "760e27df4dd966607e8fb7fd8b6b93e3c7d2e193",
    })
    use({
      "mrshmllow/document-color.nvim",
      config = [[require'config.document_color']],
      commit = "74c487f0e5accfaae033755451b9e367220693fd",
    })
    use({
      "karb94/neoscroll.nvim",
      config = [[require'config.neoscroll']],
      commit = "54c5c419f6ee2b35557b3a6a7d631724234ba97a",
    })
    use({
      "p00f/nvim-ts-rainbow",
      after = "nvim-treesitter",
      config = [[require'config.rainbow']],
      commit = "064fd6c0a15fae7f876c2c6dd4524ca3fad96750",
    })
    -- use({
    --   knob = "ufo",
    --   "kevinhwang91/promise-async",
    --   commit = "1a30ecd708b08adaa7de8ad3d207147aadf3e081"
    -- })
    -- use({
    --   "kevinhwang91/nvim-ufo",
    --   require = "kevinhwang91/promise-async",
    --   config = [[require'config.ufo']],
    --   commit = "24067ef90dd33da08e5a27e18e0de03b93fe4c2d"
    -- })

    -- Git
    use({
      "tpope/vim-fugitive",
      cmd = { "G", "Git", "Gstatus", "Gblame", "Ggrep", "Gpush", "Gpull" },
      commit = "49cc58573e746d02024110d9af99e95994ea4b72",
    })
    use({
      "rbong/vim-flog",
      commit = "c880254c0d56a9dba0bfe7bc3a5f99cd15273363",
    })
    use({
      "tpope/vim-rhubarb",
      cmd = { "GBrowse" },
      commit = "cad60fe382f3f501bbb28e113dfe8c0de6e77c75",
    })
    use({
      "airblade/vim-gitgutter",
      commit = "400a12081f188f3fb639f8f962456764f39c6ff1",
    })
    use({
      "akinsho/git-conflict.nvim",
      config = [[require'config.git_conflict']],
      commit = "77faa75c09a6af88e7b54d8d456327e06611f7ea",
    })
    use({
      "tpope/vim-dispatch",
      commit = "00e77d90452e3c710014b26dc61ea919bc895e92",
    })
    use({
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = [[require'config.gitsigns']],
      commit = "9ff7dfb051e5104088ff80556203634fc8f8546d",
    })
    use({
      "junegunn/gv.vim",
      cmd = { "GV" },
      commit = "320cc8c477c5acc4fa0e52a460d87b2af54fa051",
    })
    -- Editing
    use({
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = [[require'config.autopairs']],
      commit = "99f696339266c22e7313d6a85a95bd538c3fc226",
    })
    use({
      "tpope/vim-surround",
      commit = "3d188ed2113431cf8dac77be61b842acb64433d9",
    })
    use({
      "tpope/vim-sleuth",
      commit = "8332f123a63c739c870c96907d987cc3ff719d24",
    })
    use({
      "tpope/vim-commentary",
      commit = "e87cd90dc09c2a203e13af9704bd0ef79303d755",
    })
    use({
      "tpope/vim-unimpaired",
      commit = "6d44a6dc2ec34607c41ec78acf81657248580bf1",
    })
    use({
      "tpope/vim-repeat",
      commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a",
    })
    use({
      "tpope/vim-abolish",
      commit = "3f0c8faadf0c5b68bcf40785c1c42e3731bfa522",
    })
    _use({
      "stevearc/dressing.nvim",
      commit = "7894d5bc504deacf37f0a479a53fa4746fe30a45",
    })
    use({
      "ziontee113/icon-picker.nvim",
      commit = "0f3b2648f6f8e788bc8dfe37bc9bb18b565cfc3c",
      config = [[require'config.icon_picker']],
      after = "dressing.nvim",
    })
    use({ "godlygeek/tabular", cmd = { "Tabularize" }, command = "339091ac4dd1f17e225fe7d57b48aff55f99b23a" })
    use({
      "editorconfig/editorconfig-vim",
      commit = "30ddc057f71287c3ac2beca876e7ae6d5abe26a0",
    })
    use({
      "chrisbra/unicode.vim",
      commit = "4c851a24310fcfb5540a7e2b17c563f1f542e3a2",
    })

    vim.api.nvim_set_keymap("n", "<space>i", "<cmd>:ZenMode<CR>", {})
    use({
      "folke/zen-mode.nvim",
      cmd = { "ZenMode" },
      config = [[require'config.zen_mode']],
      command = "6f5702db4fd4a4c9a212f8de3b7b982f3d93b03c",
    })

    use({
      "junegunn/goyo.vim",
      commit = "7f5d35a65510083ea5c2d0941797244b9963d4a9",
    })

    use({
      "junegunn/vim-easy-align",
      commit = "12dd6316974f71ce333e360c0260b4e1f81169c3",
    })

    use({
      "renerocksai/telekasten.nvim",
      config = [[require'config.telekasten']],
      commit = "9de25d16574b5eb0d9f548a456d9595e1cf82eb2",
    })

    use({
      "ellisonleao/glow.nvim",
      cmd = { "Glow" },
      commit = "9038d7cdd76a930973b6158d800c8dbc02236a4b",
    })
    use({
      "iamcco/markdown-preview.nvim",
      -- cmd = {"MarkdownPreview"},
      run = "cd app && yarn install",
      commit = "02cc3874738bc0f86e4b91f09b8a0ac88aef8e96",
    })
    use({
      'toppair/peek.nvim',
      config = [[require'config.peek']],
      run = 'deno task --quiet build:fast',
      commit = "18284b64f6c5103ccf18d6b53f288d2b2de2dc4a"
    })
    use({
      "lukas-reineke/indent-blankline.nvim",
      commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6",
    })
    use({
      "junegunn/vim-peekaboo",
      commit = "cc4469c204099c73dd7534531fa8ba271f704831",
    })
    use({
      "simnalamburt/vim-mundo",
      commit = "b53d35fb5ca9923302b9ef29e618ab2db4cc675e",
      cmd = { "MundoToggle" },
    })

    -- Misc

    use({
      "akinsho/toggleterm.nvim",
      cmd = { "ToggleTerm", "TermExec" },
      config = [[require'config.toggleterm']],
      commit = "3ba683827c623affb4d9aa518e97b34db2623093",
    })
    use({
      "tpope/vim-eunuch",
      commit = "291ef1f8c8996ca7715df1032a35a27b12d7b5cf",
    })

    -- Diagnostics
    --
    -- use {'dstein64/vim-startuptime'}
    use({
      "tweekmonster/startuptime.vim",
      commit = "dfa57f522d6f61793fe5fea65bca7484751b8ca2",
    })
  end,
  config = {
    profile = {
      enable = true,
      compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    },
  },
})
