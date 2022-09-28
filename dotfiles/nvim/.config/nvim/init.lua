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
    colorizer = 4,
    conflict_marker = 7,
    commentary = 4,
    compactcmd = 1,
    cmp = 3,
    dap = 6,
    defaults = 2,
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
    friendly_snippets = 5,
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
    nnn = 9,
    notify = 5,
    null_ls = 3,
    nvim_tree = 3,
    peekaboo = 9,
    polyglot = 9,
    rainbow = 3,
    refactoring = 5,
    rhubarb = 7,
    shortcuts = 1,
    sleuth = 3,
    spelling = 5,
    startify = 4,
    startuptime = 1,
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
    tmux_navigator = 3,
    toggleterm = 3,
    tpipeline = 9,
    treesitter = 3,
    trouble = 3,
    twightlight = 9,
    ufo = 9,
    unicode = 9,
    unimpaired = 4,
    update_spelling = 7,
    which_key = 1,
    window_cleaner = 9,
    writegood = 6,
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

return require("packer").startup({
    function(_use)
        o["runtimepath"] = o["runtimepath"] .. ",~/.vim"

        _use("lewis6991/impatient.nvim")
        _use({
            "antoinemadec/FixCursorHold.nvim",
            commit = "70a9516a64668cbfe59f31b66d0a21678c5e9b12",
        }) -- fixes https://github.com/neovim/neovim/issues/12587

        local ok, knobs = pcall(require, "knobs")
        local use = ok and knobs.use(_use) or _use

        require("config.config")

        use("wbthomason/packer.nvim")
        use("ianhomer/knobs.vim")

        _use({
            "b0o/schemastore.nvim",
            commit = "b11510e6d05c7fcbd66ed8c0d6a3ebbaef8dc0f4",
        })
        -- LSP, autocomplete and code guidance
        use({
            "neovim/nvim-lspconfig",
            event = "BufWinEnter",
            config = [[require'config.lspconfig']],
            commit = "51775b12cfbf1b6462c7b13cd020cc09e6767aea",
            after = "LuaSnip",
        })
        use({
            "weilbith/nvim-code-action-menu",
            cmd = "CodeActionMenu",
            commit = "ee599409ed6ab31f6d7115e9c5c4550336470c14",
        })
        _use({
            "onsails/lspkind-nvim",
            config = [[require("lspkind").init()]],
            commit = "f46e3b5528e73347dc0678277460e5cea2a52b6a",
        })

        use({
            "glepnir/lspsaga.nvim",
            event = "BufWinEnter",
            config = [[require'config.lspsaga']],
            commit = "365bf2eae10f6cf04aff427bfccfb4f886841cd9",
        })

        _use({
            "hrsh7th/cmp-nvim-lsp",
            commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8",
        })

        _use({
            "hrsh7th/cmp-buffer",
            commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
        })

        _use({
            "hrsh7th/cmp-path",
            commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1",
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
            "hrsh7th/cmp-nvim-lsp-signature-help",
            commit = "3dd40097196bdffe5f868d5dddcc0aa146ae41eb",
        })

        -- _use({
        --     "hrsh7th/cmp-nvim-lsp-document-symbol",
        --     commit = "c3f0086ed9882e52e0ae38dd5afa915f69054941",
        -- })

        _use({
            "hrsh7th/nvim-cmp",
            requires = "hrsh7th/cmp-buffer",
            config = [[require'config.cmp']],
            commit = "913eb8599816b0b71fe959693080917d8063b26a",
        })

        -- _use({
        --     "petertriho/cmp-git",
        --     requires = "nvim-lua/plenary.nvim",
        --     config = [[require'config.cmp_git']],
        --     commit = "fae6cdb407ad6c63a0b1928670bad1a67a55b887",
        -- })

        use({
            knob = "vsnip",
            "hrsh7th/cmp-vsnip",
            after = "cmp-nvim-lsp",
            commit = "0abfa1860f5e095a07c477da940cfcb0d273b700",
        })

        use({
            knob = "vsnip",
            "hrsh7th/vim-vsnip-integ",
            after = "cmp-nvim-lsp",
            commit = "64c2ed66406c58163cf81fb5e13ac2f9fcdfb52b",
        })

        _use({
            knob = "luasnip",
            "saadparwaiz1/cmp_luasnip",
            commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36",
        })

        _use({
            knob = "luasnip",
            "L3MON4D3/LuaSnip",
            requires = { "saadparwaiz1/cmp_luasnip" },
            commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84",
        })

        use({
            "hrsh7th/vim-vsnip",
            event = "InsertEnter",
            requires = {
                { "hrsh7th/vim-vsnip-integ", cond = "vim.g.knob_vsnip ~= nil" },
            },
            commit = "8f199ef690ed26dcbb8973d9a6760d1332449ac9",
        })
        use({
            "rafamadriz/friendly-snippets",
            commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1",
        })

        use({
            "j-hui/fidget.nvim",
            commit = "492492e7d50452a9ace8346d31f6d6da40439f0e",
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
            commit = "1533257895fa953c004f88c1d9476af50b721c7d",
            requires = { "nvim-lua/plenary.nvim" },
        })

        use({
            cmd = "Vista",
            "liuchengxu/vista.vim",
            commit = "9c3e31f67653a1d25147a8dd2a0b2724853d9923",
        })

        use({
            "rcarriga/nvim-notify",
            config = [[require'config.notify']],
            commit = "7a9be08986b4d98dd685a6b40a62fcba19c1ad27",
        })

        use({
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.trouble']],
            commit = "929315ea5f146f1ce0e784c76c943ece6f36d786",
        })
        use({
            "kevinhwang91/nvim-bqf",
            ft = "qf",
            commit = "aea31569d1b20aa6a35fa84ec756cb205a4a7134",
            config = [[require'config.bqf']],
        })

        use({
            "majutsushi/tagbar",
            cmd = "TagbarToggle",
            config = [[require'config.tagbar']],
            commit = "72cb0995d63c3b5a86ecf15e0943e249c8aab356",
        })

        use({
            "folke/lsp-colors.nvim",
            commit = "4e6da1984d23da88a947805866580c48fc3cc8d7",
        })

        use({
            "dense-analysis/ale",
            ft = { "sh", "javascript", "markdown", "lua", "python", "typescript", "vim" },
            cmd = { "ALEFix" },
            commit = "e73f0f5cb3856b7a8bfa9c51d4bf40bca5553945",
        })

        use({
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = [[require'config.treesitter']],
            run = ":TSUpdate",
            commit = "8ec59aee8097c64fcf27d1dbd77ea181c50846c5",
        })

        use({
            knob = "treesitter",
            "nvim-treesitter/nvim-treesitter-textobjects",
            config = [[require'config.treesitter_textobjects']],
            commit = "e63c2ff8e38fad77299dd74e14c7c9360e1b3181",
        })

        use({
            "preservim/vimux",
            commit = "740320b798106c5de6758fb35bf39e79ee1ce0f0",
        })
        use({
            "vim-test/vim-test",
            commit = "dae07571033b075d8a334e7e13a8987528483f59",
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
            commit = "437f446f3fc683b1eaca75b282da0c38b5fd6245",
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
            commit = "bbd3e7e15ac6b5e7aceb680515f7352d6a0953be",
        })
        use({
            knob = "dap",
            "rcarriga/nvim-dap-ui",
            requires = "mfussenegger/nvim-dap",
            config = [[require'config.dapui']],
            commit = "4af75ae48a213aede653b1954459a47b3fc18dac",
        })
        use({
            "puremourning/vimspector",
            config = [[require'config.vimspector']],
            commit = "3378018bc1cdd1d9b70734c3e970bc52fd983415",
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
            commit = "ecbf9cd98e65e9170ef743d229f35bf1306efde1",
        })
        _use({
            "nvim-lua/plenary.nvim",
            commit = "62dc2a7acd2fb2581871a36c1743b29e26c60390",
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
            commit = "30e2dc5232d0dd63709ef8b44a5d6184005e8602",
        })

        use({
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.nvimtree']],
            cmd = { "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle" },
            commit = "3676e0b124c2a132857e2bbcf7f48f05228f1052",
        })
        use({
            "ryanoasis/vim-devicons",
            commit = "a2258658661e42dd4cdba4958805dbad1fe29ef4",
        })
        use({ "wfxr/minimap.vim", cmd = { "Minimap" }, commit = "3801d9dfaa5431e7b83ae6f98423ac077d9f5c3f" })
        use({
            "folke/which-key.nvim",
            event = "BufWinEnter",
            config = [[require'config.which_key']],
            commit = "6885b669523ff4238de99a7c653d47b081b5506d",
        })
        use({
            "phaazon/hop.nvim",
            config = [[require'config.hop']],
            commit = "2a1b686aad85a3c241f8cd8fd42eb09c7de5ed79",
        })
        use({
            "ggandor/lightspeed.nvim",
            commit = "a5b79ddbd755ac8d21a8704c370b5f643dda94aa",
        })
        use({
            "christoomey/vim-tmux-navigator",
            commit = "afb45a55b452b9238159047ce7c6e161bd4a9907",
        })

        use({
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            config = [[require'config.lualine']],
            commit = "a52f078026b27694d2290e34efa61a6e4a690621",
        })
        use({
            "vimpostor/vim-tpipeline",
            commit = "7c820414b7ba6280e774c10df4bea6798ce5b031",
        })
        use({
            "romgrk/barbar.nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
            config = [[require'config.barbar']],
            commit = "c41ad6e3f68c2c9f6aa268c6232cdef885107303",
        })

        -- Style
        use({
            "morhetz/gruvbox",
            commit = "bf2885a95efdad7bd5e4794dd0213917770d79b7",
        })
        use({
            "lifepillar/gruvbox8",
            commit = "f94afba273ec544e1e73e82c78674eed4ccb1c8c",
        })
        use({
            "rebelot/kanagawa.nvim",
            commit = "dda1b8c13e0e7588c014064e5e8baf7f2953dd29",
            config = [[require'config.kanagawa']],
        })
        use({
            "NvChad/nvim-colorizer.lua",
            config = [[require'config.colorizer']],
            event = "BufRead",
            commit = "004a2b3ef62b01d3d1db454d1efe76d31934d43b",
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
            commit = "fad8badcd9baa4deb2cf2a5376ab412a1ba41797",
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
            commit = "dd8107cabf5fe85df94d5eedcae52415e543f208",
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
            commit = "f19b6203191d69de955d91467a5707959572119b",
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
            commit = "f98c85e7c3d65a51f45863a34feb4849c82f240f",
        })
        use({
            "junegunn/gv.vim",
            cmd = { "GV" },
            commit = "1507838ee67f9b298def89cbfc404a0fee4a4b8c",
        })
        -- Editing
        use({
            "windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = [[require'config.autopairs']],
            commit = "14cc2a4fc6243152ba085cc2059834113496c60a",
        })
        use({
            "tpope/vim-surround",
            commit = "bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea",
        })
        use({
            "tpope/vim-sleuth",
            commit = "1d25e8e5dc4062e38cab1a461934ee5e9d59e5a8",
        })
        use({
            "tpope/vim-commentary",
            commit = "3654775824337f466109f00eaf6759760f65be34",
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
            commit = "76477792b34f8fed167b5aa61a325e4dab26c3d7",
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
            commit = "d354117b72b3b43b75a29b8e816c0f91af10efe9",
        })
        use({
            "chrisbra/unicode.vim",
            commit = "92878e4ebd8df9e225c35b92985b7b6996e6cd5f",
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
            commit = "fdb089daf6d66e9d559645e664a172ff5b6a5ddd",
        })

        use({
            "ellisonleao/glow.nvim",
            cmd = { "Glow" },
            commit = "8dca3583e44d54bcfd79cb8dc06ddb89128aa5e0",
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
            commit = "3c7e008a9922702be979dbfe3c5280313f53618b",
            cmd = { "MundoToggle" },
        })

        -- Misc

        use({
            "akinsho/toggleterm.nvim",
            cmd = { "ToggleTerm", "TermExec" },
            config = [[require'config.toggleterm']],
            commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda",
        })
        use({
            "tpope/vim-eunuch",
            commit = "cc564695076d89b3d1e06b2693fca788cfbc5910",
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
