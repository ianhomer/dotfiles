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
  rhubarb = 7,
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
      commit = "571056608b7fc569f856c8174fcbffaad548eec5",
    })
    -- LSP, autocomplete and code guidance
    use({
      "neovim/nvim-lspconfig",
      event = "BufWinEnter",
      config = [[require'config.lspconfig']],
      commit = "ed88435764d8b00442e66d39ec3d9c360e560783",
    })
    use({
      "weilbith/nvim-code-action-menu",
      cmd = "CodeActionMenu",
      commit = "e4399dbaf6eabff998d3d5f1cbcd8d9933710027",
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
      commit = "225e4eff08dae8aaa2b7cdce1497fc90e1e46882",
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
      commit = "f3491638d123cfd2c8048aefaf66d246ff250ca6",
    })

    _use({
      knob = "lsp_signature",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      commit = "d2768cb1b83de649d57d967085fe73c5e01f8fd7",
    })

    _use({
      knob = "luasnip",
      "saadparwaiz1/cmp_luasnip",
      commit = "18095520391186d634a0045dacaa346291096566",
    })

    _use({
      knob = "luasnip",
      "L3MON4D3/LuaSnip",
      requires = { "saadparwaiz1/cmp_luasnip" },
      commit = "5d57303efde86fcb0959c52b1a6d40f923940f34",
    })

    _use({
      "hrsh7th/nvim-cmp",
      requires = "hrsh7th/cmp-buffer",
      config = [[require'config.cmp']],
      commit = "11a95792a5be0f5a40bab5fc5b670e5b1399a939",
      -- after = "LuaSnip",
    })

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
      commit = "915558963709ea17c5aa246ca1c9786bfee6ddb4",
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
      commit = "b005821516f1f37801a73067afd1cef2dbc4dfe8",
    })

    use({
      "folke/noice.nvim",
      event = "VimEnter",
      config = [[require'config.noice']],
      commit = "78047d4f5bbec88dc7b5cf012ccf199e2e0a5c96",
      requires = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    })

    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = [[require'config.trouble']],
      commit = "83ec606e7065adf134d17f4af6bae510e3c491c1",
    })
    use({
      "kevinhwang91/nvim-bqf",
      ft = "qf",
      commit = "22e9551468c8d9d9d2d4e682c6d25a1204f389a3",
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
      commit = "750d59b643865b906996028147675e9af216ea95",
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      config = [[require'config.treesitter']],
      run = ":TSUpdate",
      commit = "51d220e0bd8922caabcb3e5de936fc599a1bd210",
    })

    use({
      knob = "treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
      config = [[require'config.treesitter_textobjects']],
      commit = "a8c86f48c1030acee22b9e071e3c531de77bf253",
    })

    use({
      knob = "treesitter",
      "nvim-treesitter/nvim-treesitter-context",
      config = [[require'config.treesitter_context']],
      commit = "cacee4828152dd3a83736169ae61bbcd29a3d213",
    })

    use({
      "vim-test/vim-test",
      commit = "ca2502545a8c563e15f556d0eb8a59e0f74d2864",
    })
    use({
      knob = "neotest",
      "nvim-neotest/neotest-vim-test",
      commit = "07f25ab7ba4e7646b38c84e10002b195a53b0096",
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
      commit = "fee5ce9bdc3dff4706a29b012e75025ab376becb",
      config = [[require'config.neotest']],
    })
    use({
      knob = "dap",
      "nvim-telescope/telescope-dap.nvim",
      commit = "313d2ea12ae59a1ca51b62bf01fc941a983d9c9c",
    })
    use({
      "mfussenegger/nvim-dap",
      config = [[require'config.dap']],
      commit = "b8201fd104287e9c24f898f1f7f5202896eea203",
    })
    use({
      knob = "dap",
      "rcarriga/nvim-dap-ui",
      requires = "mfussenegger/nvim-dap",
      config = [[require'config.dapui']],
      commit = "b80227ea56a48177786904f6322abc8b2dc0bc36",
    })
    use({
      "puremourning/vimspector",
      config = [[require'config.vimspector']],
      commit = "475d75a32e368dbfc700b580b16b351face72129",
    })

    use({
      "ThePrimeagen/refactoring.nvim",
      commit = "b253bcee0488209875fafceda0d0832a121fa3c7",
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

    use({ "mhinz/vim-startify",
      commit = "81e36c352a8deea54df5ec1e2f4348685569bed2" })
    use({
      "junegunn/fzf.vim",
      cmd = { "Ag", "Buffers", "Commits", "Files", "History" },
      fn = { "fzf#vim#ag" },
      ft = { "qf" },
      commit = "9c37e6801b432a4046511b14414f488487b61973",
    })
    _use({
      "nvim-lua/plenary.nvim",
      commit = "1c7e3e6b0f4dd5a174fcea9fda8a4d7de593b826",
    })
    _use({
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      commit = "fab3e2212e206f4f8b3bbaa656e129443c9b802e",
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
      commit = "1ba7278cf08da8048e7f589ef6b65a39fd3e4dbf",
    })

    use({
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = [[require'config.nvimtree']],
      cmd = { "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle" },
      commit = "3ce0a8e770f70a135ef969e0a640bd8d05baf42c",
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
      commit = "e4fa445065a2bb0bbc3cca85346b67817f28e83e",
    })
    use({
      "ggandor/lightspeed.nvim",
      commit = "299eefa6a9e2d881f1194587c573dad619fdb96f",
    })

    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = [[require'config.lualine']],
      commit = "0050b308552e45f7128f399886c86afefc3eb988",
      after = "noice.nvim",
    })
    use({
      "romgrk/barbar.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = [[require'config.barbar']],
      commit = "c1b5d351ccd8f88fd2729b90ade2ef5d333463de",
    })

    -- Style
    use({
      "rebelot/kanagawa.nvim",
      commit = "476eb2289d47d132ebacc1a4d459e3204866599b",
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
    use({
      knob = "ufo",
      "kevinhwang91/promise-async",
      commit = "7fa127fa80e7d4d447e0e2c78e99af4355f4247b",
    })
    use({
      "kevinhwang91/nvim-ufo",
      require = "kevinhwang91/promise-async",
      config = [[require'config.ufo']],
      commit = "b70c9ef0f8e2673a11387a39185ff249e00df19f",
    })

    -- Git
    use({
      "tpope/vim-fugitive",
      cmd = { "G", "Git", "Gstatus", "Gblame", "Ggrep", "Gpush", "Gpull" },
      commit = "9c5f675db54139c18ed4a1a18989ea2da37d6cae",
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
      commit = "00df1089b6267f47c7c0f13536789feb9db1e65b",
    })
    use({
      "akinsho/git-conflict.nvim",
      config = [[require'config.git_conflict']],
      commit = "cbefa7075b67903ca27f6eefdc9c1bf0c4881017",
    })
    use({
      "tpope/vim-dispatch",
      commit = "00e77d90452e3c710014b26dc61ea919bc895e92",
    })
    use({
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = [[require'config.gitsigns']],
      commit = "7b37bd5c2dd4d7abc86f2af096af79120608eeca",
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
      commit = "f00eb3b766c370cb34fdabc29c760338ba9e4c6c",
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
      commit = "aa3428b734ddbd0105615832843f619774a6871e",
    })
    _use({
      "stevearc/dressing.nvim",
      commit = "4436d6f41e2f6b8ada57588acd1a9f8b3d21453c",
    })
    use({
      "ziontee113/icon-picker.nvim",
      commit = "0f3b2648f6f8e788bc8dfe37bc9bb18b565cfc3c",
      config = [[require'config.icon_picker']],
      after = "dressing.nvim",
    })
    use({ "godlygeek/tabular", cmd = { "Tabularize" },
      command = "339091ac4dd1f17e225fe7d57b48aff55f99b23a" })
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
      command = "4313a5828e4d48c5f2f135f29d46f769a59dcfdc",
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
      "ellisonleao/glow.nvim",
      cmd = { "Glow" },
      commit = "4e4c6486110d9d9905d2efc5fd2d562212f0d212",
    })
    use({
      "iamcco/markdown-preview.nvim",
      -- cmd = {"MarkdownPreview"},
      run = "cd app && yarn install",
      commit = "02cc3874738bc0f86e4b91f09b8a0ac88aef8e96",
    })
    use({
      "lukas-reineke/indent-blankline.nvim",
      commit = "c4c203c3e8a595bc333abaf168fcb10c13ed5fb7",
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
      commit = "a54e6c471ce1cd8ef8357e34598a28a955297131",
    })
    use({
      "tpope/vim-eunuch",
      commit = "291ef1f8c8996ca7715df1032a35a27b12d7b5cf",
    })

    -- Diagnostics

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
