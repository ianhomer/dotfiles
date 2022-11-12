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
  markdown_preview = 3,
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
      commit = "f92c7fce6a8ddb5b5b906d5cf7a2985b4741b9a8",
    })
    -- LSP, autocomplete and code guidance
    use({
      "neovim/nvim-lspconfig",
      event = "BufWinEnter",
      config = [[require'config.lspconfig']],
      commit = "c96ec574eacfff8ad8dd4bdb6e96a1b3dbd268fd",
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
      commit = "201dbbd13d6bafe1144475bbcae9efde224e07ec",
    })

    _use({
      "hrsh7th/cmp-nvim-lsp",
      commit = "78924d1d677b29b3d1fe429864185341724ee5a2",
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
      commit = "c66c379915d68fb52ad5ad1195cdd4265a95ef1e",
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
      commit = "619796e2477f7233e5fdff456240676a08482684",
    })

    _use({
      "hrsh7th/nvim-cmp",
      requires = "hrsh7th/cmp-buffer",
      config = [[require'config.cmp']],
      commit = "cdb77665bbf23bd2717d424ddf4bf98057c30bb3",
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
      commit = "2cf9997d3bde2323a1a0934826ec553423005a26",
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
      commit = "07d4ed4c6b561914aafd787453a685598bec510f",
      requires = { "nvim-lua/plenary.nvim" },
    })

    use({
      cmd = "Vista",
      "liuchengxu/vista.vim",
      commit = "9ddb3707b066cb288aa1ac9c33477280e0ef95d3",
    })

    use({
      "rcarriga/nvim-notify",
      config = [[require'config.notify']],
      commit = "354e0ebb269d9e4feca073372431e8453f5f262a",
    })

    use({
      "folke/noice.nvim",
      event = "VimEnter",
      config = [[require'config.noice']],
      commit = "3489e57e198e4b161169a538d2bd71e018de41d0",
      requires = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    })

    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = [[require'config.trouble']],
      commit = "ed65f84abc4a1e5d8f368d7e02601fc0357ea15e",
    })
    use({
      "kevinhwang91/nvim-bqf",
      ft = "qf",
      commit = "3a79f7ce4f6e11eeffe55ba4bde01cdc20da08c0",
      config = [[require'config.bqf']],
    })

    use({
      "majutsushi/tagbar",
      cmd = "TagbarToggle",
      config = [[require'config.tagbar']],
      commit = "6c3e15ea4a1ef9619c248c2b1eced56a47b61a9e",
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
      commit = "47bda4171aad2ee990a35ddb6319ceedc4d78b5d",
    })

    use({
      knob = "treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
      config = [[require'config.treesitter_textobjects']],
      commit = "13739a5705d9592cbe7da372576363dc8ea5f723",
    })

    use({
      knob = "treesitter",
      "nvim-treesitter/nvim-treesitter-context",
      config = [[require'config.treesitter_context']],
      commit = "0dd5eae6dbf226107da2c2041ffbb695d9e267c1",
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
      commit = "7e73ba56602cb7439e804113ef2e6d6000ca9b11",
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
      commit = "61643680dcb771a29073cd432894e2f81a7c2ae3",
    })
    use({
      knob = "dap",
      "rcarriga/nvim-dap-ui",
      requires = "mfussenegger/nvim-dap",
      config = [[require'config.dapui']],
      commit = "d7a9f032e7e45b37d778ef83e3d412566ba97cb5",
    })
    use({
      "puremourning/vimspector",
      config = [[require'config.vimspector']],
      commit = "037152a045c180826382d5487cf278170f0653ad",
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
      commit = "65c0ee3d4bb9cb696e262bca1ea5e9af3938fc90",
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
      commit = "7a4ffef931769c3fe7544214ed7ffde5852653f6",
    })

    use({
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = [[require'config.nvimtree']],
      cmd = { "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle" },
      commit = "e204a7d819a9a065d5b1cdc6f59d2d2777d14a0f",
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
      commit = "3325d5d43a7a2bc9baeef2b7e58e1d915278beaf",
      after = "noice.nvim",
    })
    use({
      "romgrk/barbar.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = [[require'config.barbar']],
      commit = "eecabfedc9429f6184feb3b6655bc45a4ed36a7e",
    })

    -- Style
    use({
      "rebelot/kanagawa.nvim",
      commit = "52cfa270317121672c1416c725361fa653684de0",
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
      commit = "01f3e0af928857128eec8d998948b80ed1678c18",
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
      commit = "0f87781ad92957a5354197baed9a6ace56332aa7",
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
      commit = "6b6e35fc9aca1030a74cc022220bc22ea6c5daf4",
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
      commit = "efdc6475f7ea789346716dabf9900ac04ee8604a",
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
      commit = "8c1500069cafc9cfd93bf5521b17fde060008022",
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
      commit = "6bba2596601086ddfc882488b1444bf1ea43aab9",
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
      commit = "de4502bd558e05ce617df177acff2c1e86f39155",
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
