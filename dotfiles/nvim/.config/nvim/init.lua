local g = vim.g
local o = vim.o
local nvim_set_var = vim.api.nvim_set_var

vim.opt.shell = "/bin/bash"

local impatientOk, _ = pcall(require, "impatient")
if impatientOk then
    _.enable_profile()
end

require("config/core")

nvim_set_var("knobs_default_level", 5)

-- Levels at which knobs are enabled
nvim_set_var("knobs_levels", {
    ale = 9,
    apathy = 6,
    airline = 9,
    autopairs = 3,
    autosave = 3,
    barbar = 6,
    bqf = 5,
    colorizer = 4,
    conflict_marker = 7,
    commentary = 4,
    compactcmd = 1,
    cmp = 4,
    dap = 5,
    defaults = 2,
    devicons = 4,
    dispatch = 4,
    easy_align = 3,
    editorconfig = 4,
    endwise = 7,
    eunuch = 3,
    fidget = 3,
    fugitive = 3,
    frecency = 9,
    friendly_snippets = 5,
    fzf = 3,
    gitgutter = 6,
    gitsigns = 4,
    gruvbox = 9,
    gruvbox8 = 9,
    glow = 3,
    goyo = 9,
    gv = 5,
    hop = 6,
    indent_blankline = 4,
    indentline = 4,
    kanagawa = 3,
    nerdtree = 9,
    lens = 8,
    lightbulb = 4,
    lightspeed = 5,
    lsp = 4,
    lsp_colors = 3,
    lspconfig = 4,
    lspkind = 4,
    lsp_signature = 6,
    lualine = 3,
    markdown_syntax_table = 3,
    markdown_preview = 3,
    minimap = 9,
    modes = 3,
    mundo = 3,
    neoscroll = 3,
    nnn = 9,
    null_ls = 3,
    nvim_tree = 3,
    peekaboo = 9,
    polyglot = 9,
    rainbow = 9,
    refactoring = 3,
    rhubarb = 7,
    shortcuts = 1,
    spelling = 4,
    startify = 4,
    startuptime = 1,
    surround = 3,
    tabcomplete = 9,
    tabular = 3,
    telescope = 4,
    test = 9,
    thingity = 3,
    tmux_navigator = 3,
    toggleterm = 3,
    treesitter = 3,
    trouble = 5,
    twightlight = 9,
    unicode = 4,
    unimpaired = 4,
    update_spelling = 7,
    which_key = 1,
    window_cleaner = 9,
    writegood = 6,
    vimspector = 9,
    vsnip = 3,
    zen_mode = 3,
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

        local ok, knobs = pcall(require, "knobs")
        local use = ok and knobs.use(_use) or _use

        use("wbthomason/packer.nvim")
        use("ianhomer/knobs.vim")

        -- LSP, autocomplete and code guidance
        _use({
            "neovim/nvim-lspconfig",
            config = [[require'config.lspconfig']],
            commit = "99596a8cabb050c6eab2c049e9acde48f42aafa4",
        })
        use({
            "weilbith/nvim-code-action-menu",
            cmd = "CodeActionMenu",
            commit = "a864a79c8e024d4f5d95915210188c9c3430b160",
        })
        _use({
            "onsails/lspkind-nvim",
            config = [[require("lspkind").init()]],
            commit = "93e98a0c900327ce7e9be1cbf24aebbe7170e375",
        })

        _use({
            "hrsh7th/cmp-nvim-lsp",
            commit = "ebdfc204afb87f15ce3d3d3f5df0b8181443b5ba",
        })

        _use({
            "hrsh7th/cmp-buffer",
            commit = "d66c4c2d376e5be99db68d2362cd94d250987525",
        })

        _use({
            "hrsh7th/cmp-path",
            commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e",
        })

        _use({
            "hrsh7th/cmp-cmdline",
            commit = "f4beb74e8e036f9532bedbcac0b93c7a55a0f8b0",
        })

        _use({
            "hrsh7th/cmp-nvim-lua",
            commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21",
        })

        _use({
            "hrsh7th/cmp-nvim-lsp-signature-help",
            commit = "8014f6d120f72fe0a135025c4d41e3fe41fd411b",
        })

        _use({
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            commit = "c3f0086ed9882e52e0ae38dd5afa915f69054941",
        })

        _use({
            "hrsh7th/nvim-cmp",
            requires = "hrsh7th/cmp-buffer",
            config = [[require'config.cmp']],
            commit = "b5433f901ebffc9e01b82ae13da9a92d49569205",
        })

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
            commit = "5541e4ac18c732700c4310c86384bea19644d4a7",
        })

        use({
            "hrsh7th/vim-vsnip",
            event = "InsertEnter",
            requires = {
                { "hrsh7th/vim-vsnip-integ", cond = "vim.g.knob_vsnip ~= nil" },
            },
            commit = "70a1131d64d75150ece513b983b0f42939bcb03c",
        })
        use({
            "rafamadriz/friendly-snippets",
            commit = "e302658e765cf20e6af5a1be8cc07a996d6ee2cc",
        })

        use({
            "j-hui/fidget.nvim",
            commit = "f3146acf9b3357206da11c06af1e7a5206a146d8",
            config = [[require'fidget'.setup{}]],
        })

        use({
            "kosayoda/nvim-lightbulb",
            config = [[require'config.lightbulb']],
            commit = "29ca81408119ba809d1f922edc941868af97ee86",
        })

        use({
            "jose-elias-alvarez/null-ls.nvim",
            config = [[require'config.null_ls']],
            commit = "8f7af2ef9d9ff5e331be6725c39ce89a79b36bbc",
            requires = { "nvim-lua/plenary.nvim" },
        })

        use({
            cmd = "Vista",
            "liuchengxu/vista.vim",
            commit = "f9c8c8ad4135346a945e1ebfb00b723976d92dfc",
        })

        -- Lua
        use({
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.trouble']],
            commit = "691d490cc4eadc430d226fa7d77aaa84e2e0a125",
        })
        use({
            "kevinhwang91/nvim-bqf",
            ft = "qf",
            commit = "347ecd67f5a53032877621fdf4d94a062a2a79d7",
            config = [[require'config.bqf']],
        })

        use({
            "majutsushi/tagbar",
            cmd = "TagbarToggle",
            config = [[require'config.tagbar']],
            commit = "ccee72f1d1ed71a001e57592bd585ae77c5f83b2",
        })

        use({
            "folke/lsp-colors.nvim",
            commit = "517fe3ab6b63f9907b093bc9443ef06b56f804f3",
        })

        use({
            "dense-analysis/ale",
            ft = { "sh", "javascript", "markdown", "lua", "python", "typescript", "vim" },
            cmd = { "ALEFix" },
            commit = "607f33a1b0f662d9809d54363e8e81a4965862ce",
        })

        use({
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = [[require'config.treesitter']],
            run = ":TSUpdate",
            commit = "a189323454d1215c682c7ad7db3e6739d26339c4",
        })
        use({
            "vim-test/vim-test",
            commit = "2240d7a4b868cb594b7d83544e1b6db4df806e5e",
        })
        use({
            knob = "dap",
            "nvim-telescope/telescope-dap.nvim",
            commit = "b4134fff5cbaf3b876e6011212ed60646e56f060",
        })
        use({
            "mfussenegger/nvim-dap",
            config = [[require'config.dap']],
            commit = "763f74576b5f17c181e6a68aa575f527a5aaa012",
        })
        use({
            knob = "dap",
            "rcarriga/nvim-dap-ui",
            requires = "mfussenegger/nvim-dap",
            config = [[require'config.dapui']],
            commit = "041f6a78ee3f850dfcec5b3c5a6e81bca9164ae0",
        })
        use({
            "puremourning/vimspector",
            config = [[require'config.vimspector']],
            commit = "ebeebc121423a5ab9a31c996f9881880b658c644",
        })

        use({
            "ThePrimeagen/refactoring.nvim",
            commit = "94eaa199ad892f26d2c8594dbbc5656314cf5bdb",
            config = [[require'config.refactoring']],
            requires = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-treesitter/nvim-treesitter" },
            },
        })

        -- Navigation

        use({ "mhinz/vim-startify", commit = "81e36c352a8deea54df5ec1e2f4348685569bed2" })
        use({
            "junegunn/fzf.vim",
            cmd = { "Ag", "Buffers", "Commits", "Files", "History" },
            fn = { "fzf#vim#ag" },
            ft = { "qf" },
            requires = { { "junegunn/fzf", opt = true, fn = { "fzf#shellescape" }, ft = { "qf" } } },
            commit = "d5f1f8641b24c0fd5b10a299824362a2a1b20ae0",
        })
        use({
            "nvim-lua/plenary.nvim",
            commit = "78dde9bc25af3e657eb829058bf179739f7e8e69",
        })
        use({
            knob = "telescope",
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            commit = "8ec164b541327202e5e74f99bcc5fe5845720e18",
        })
        use({ knob = "frecency", "tami5/sqlite.lua", commit = "9ccd2a6538d8a201d1ea08784bd866950e1b4130" })

        use({
            knob = "frecency",
            "nvim-telescope/telescope-frecency.nvim",
            after = { "sqlite.lua" },
            commit = "979a6f3d882b7b5352cc6a751faa9c9427d40e74",
        })

        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                { "nvim-lua/popup.nvim", cond = "vim.g['knob_telescope']" },
                { "nvim-lua/plenary.nvim", cond = "vim.g['knob_telescope']" },
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    cond = "vim.g['knob_telescope']",
                },
                { "nvim-telescope/telescope-frecency.nvim", cond = "vim.g['knob_frecency']" },
            },
            config = [[require'config.telescope']],
            commit = "b7ae91c82b33f8f347fa060208adb3da80ae9260",
        })

        use({
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.nvimtree']],
            cmd = { "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle" },
            commit = "84993e9e9fbc1a3bd851a52f13575786ec6f5262",
        })
        use({
            "ryanoasis/vim-devicons",
            commit = "a2258658661e42dd4cdba4958805dbad1fe29ef4",
        })
        use({ "wfxr/minimap.vim", cmd = { "Minimap" }, commit = "3395cbd51bf042ef6d2cd714eb493eb7ed5fbb76" })
        use({
            "folke/which-key.nvim",
            event = "BufWinEnter",
            config = [[require'config.which_key']],
            commit = "a3c19ec5754debb7bf38a8404e36a9287b282430",
        })
        use({
            "phaazon/hop.nvim",
            config = [[require'config.hop']],
            commit = "e2f978b50c2bd9ae2c6a4ebdf2222c0f299c85c3",
        })
        use({
            "ggandor/lightspeed.nvim",
            commit = "cfde2b2fe0dafc5684780399961595357998f611",
        })
        use({
            "christoomey/vim-tmux-navigator",
            commit = "9ca5bfe5bd274051b5dd796cc150348afc993b80",
        })

        use({
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            config = [[require'config.lualine']],
            commit = "63f74ac06978cead7cd0cbbb65c80bcda2eede41",
        })
        use({
            "romgrk/barbar.nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
            config = [[require'config.barbar']],
            commit = "be65945626fb6bf6058cae61d5176d156f923c11",
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
            commit = "acf0f5d61236b416c804d649cd76db8390de9ae6",
            config = [[require'config.kanagawa']],
        })
        use({
            "norcalli/nvim-colorizer.lua",
            config = [[require'config.colorizer']],
            cmd = "BufRead",
            commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6",
        })
        use({
            "karb94/neoscroll.nvim",
            config = [[require'config.neoscroll']],
            commit = "cd4278795ed8ee120a97078b03aa6436802126d9",
        })
        -- use({
        --     "p00f/nvim-ts-rainbow",
        --     config = [[require'config.rainbow']],
        --     commit = "ac5032edc1d3e9216d081d130a14d4fcaf6cd3b3"
        -- })

        -- Git
        use({
            "tpope/vim-fugitive",
            cmd = { "G", "Git", "Gstatus", "Gblame", "Ggrep", "Gpush", "Gpull" },
            commit = "4b0f2b604562e9681ae3b80c2665f168ac637cea",
        })
        use({
            "tpope/vim-rhubarb",
            cmd = { "GBrowse" },
            commit = "977b3ccbad1f7e5370354ae409fb2ea4a7ce2058",
        })
        use({
            "airblade/vim-gitgutter",
            commit = "d5bae104031bb1633cb5c5178dc7d4ac422b422a",
        })
        use({
            "tpope/vim-dispatch",
            commit = "00e77d90452e3c710014b26dc61ea919bc895e92",
        })
        use({
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = [[require'config.gitsigns']],
            commit = "9e0cc25cbe399e0d1732ae1177dd537c462a40d1",
        })
        use({
            "junegunn/gv.vim",
            cmd = { "GV" },
            commit = "386d770e916dd680d1d622e715b9eb3a77f21bd1",
        })
        -- Editing
        use({
            "windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = [[require'config.autopairs']],
            commit = "38d486a1c47ae2722a78cf569008de0a64f4b153",
        })
        use({
            "tpope/vim-surround",
            commit = "81fc0ec460dd8b25a76346e09aecdbca2677f1a7",
        })
        use({
            "tpope/vim-commentary",
            commit = "3654775824337f466109f00eaf6759760f65be34",
        })
        use({
            "tpope/vim-unimpaired",
            commit = "80ab990c7ff7251f43262aae4b60ff6eff2ef3a4",
        })

        use({
            "tpope/vim-repeat",
            commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a",
        })
        use({ "godlygeek/tabular", cmd = { "Tabularize" }, command = "339091ac4dd1f17e225fe7d57b48aff55f99b23a" })

        use({
            "editorconfig/editorconfig-vim",
            commit = "a8e3e66deefb6122f476c27cee505aaae93f7109",
        })
        use({
            "chrisbra/unicode.vim",
            commit = "664d7b2e5cedf36ea3a85ad7e8e28e43c16f025b",
        })

        vim.api.nvim_set_keymap("n", "<space>i", "<cmd>:ZenMode<CR>", {})
        use({
            "folke/zen-mode.nvim",
            cmd = { "ZenMode" },
            config = [[require'config.zen_mode']],
            command = "f1cc53d32b49cf962fb89a2eb0a31b85bb270f7c",
        })

        use({
            "junegunn/goyo.vim",
            commit = "a865dec7ca7616dbbd69315ad1417b84d0c411f8",
        })

        use({
            "junegunn/vim-easy-align",
            commit = "12dd6316974f71ce333e360c0260b4e1f81169c3",
        })

        use({
            "ellisonleao/glow.nvim",
            cmd = { "Glow" },
            commit = "0c76518e440f2ea4dbadd87beec8eea4ce030f17",
        })
        use({
            "iamcco/markdown-preview.nvim",
            -- cmd = {"MarkdownPreview"},
            run = "cd app && yarn install",
            commit = "e5bfe9b89dc9c2fbd24ed0f0596c85fd0568b143",
        })
        use({
            "lukas-reineke/indent-blankline.nvim",
            commit = "045d9582094b27f5ae04d8b635c6da8e97e53f1d",
        })
        use({
            "junegunn/vim-peekaboo",
            commit = "cc4469c204099c73dd7534531fa8ba271f704831",
        })
        use({
            "simnalamburt/vim-mundo",
            commit = "595ee332719f397c2441d85f79608113957cc78f",
            cmd = { "MundoToggle" },
        })

        -- Misc

        use({
            "akinsho/toggleterm.nvim",
            cmd = { "ToggleTerm", "TermExec" },
            config = [[require'config.toggleterm']],
            commit = "ed812c8eb4d2a297a6a74bd63f3e892179b92776",
        })
        use({
            "tpope/vim-eunuch",
            commit = "c7360eb57bd63f5b3c82d2219d4bbe3a8b4f7dff",
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
