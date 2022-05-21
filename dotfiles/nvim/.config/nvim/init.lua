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
    abolish = 5,
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
    cmp = 5,
    dap = 6,
    defaults = 2,
    devicons = 4,
    dispatch = 4,
    easy_align = 3,
    editorconfig = 5,
    endwise = 7,
    eunuch = 3,
    fidget = 3,
    flog = 5,
    fugitive = 3,
    frecency = 9,
    friendly_snippets = 5,
    fzf = 3,
    git_conflict = 5,
    gitgutter = 6,
    gitsigns = 5,
    gruvbox = 9,
    gruvbox8 = 9,
    glow = 3,
    goyo = 9,
    gv = 5,
    hop = 6,
    indent_blankline = 5,
    indentline = 5,
    kanagawa = 3,
    nerdtree = 9,
    lens = 8,
    lightbulb = 5,
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
    rainbow = 5,
    refactoring = 7,
    rhubarb = 7,
    shortcuts = 1,
    spelling = 5,
    startify = 4,
    startuptime = 1,
    surround = 3,
    symbols_outline = 5,
    tabcomplete = 9,
    tabular = 3,
    telescope = 4,
    telekasten = 9,
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
            commit = "9e6bcf5a8915e8423d5cc7f82c5069c11272184d",
        })
        use({
            "weilbith/nvim-code-action-menu",
            cmd = "CodeActionMenu",
            commit = "a864a79c8e024d4f5d95915210188c9c3430b160",
        })
        _use({
            "onsails/lspkind-nvim",
            config = [[require("lspkind").init()]],
            commit = "57e5b5dfbe991151b07d272a06e365a77cc3d0e7",
        })

        _use({
            "hrsh7th/cmp-nvim-lsp",
            commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8",
        })

        _use({
            "hrsh7th/cmp-buffer",
            commit = "12463cfcd9b14052f9effccbf1d84caa7a2d57f0",
        })

        _use({
            "hrsh7th/cmp-path",
            commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e",
        })

        _use({
            "hrsh7th/cmp-cmdline",
            commit = "c36ca4bc1dedb12b4ba6546b96c43896fd6e7252",
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
            commit = "6e1e3865158f340d6cd3936937eb56947b5a90f9",
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
            commit = "64c2ed66406c58163cf81fb5e13ac2f9fcdfb52b",
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
            commit = "5b75fd3b13ef92f67982f56c066c7877a770741e",
        })

        use({
            "j-hui/fidget.nvim",
            commit = "37d536bbbee47222ddfeca0e8186e8ee6884f9a2",
            config = [[require'fidget'.setup{}]],
        })

        use({
            "kosayoda/nvim-lightbulb",
            config = [[require'config.lightbulb']],
            commit = "1adc99adcfe2f3e2b3051f6449e1673e66643e77",
        })

        use({
            "jose-elias-alvarez/null-ls.nvim",
            config = [[require'config.null_ls']],
            commit = "09efad6fcd3ba2394bc456a70ce47fac68793a6d",
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
            commit = "da61737d860ddc12f78e638152834487eabf0ee5",
        })
        use({
            "kevinhwang91/nvim-bqf",
            ft = "qf",
            commit = "9765a7d636b3286ccc7b6f5cea3b15250babfd48",
            config = [[require'config.bqf']],
        })

        use({
            "majutsushi/tagbar",
            cmd = "TagbarToggle",
            config = [[require'config.tagbar']],
            commit = "a577ee4d650476243d91698f2d1228819c5fa0a5",
        })

        use({
            "folke/lsp-colors.nvim",
            commit = "517fe3ab6b63f9907b093bc9443ef06b56f804f3",
        })

        use({
            "dense-analysis/ale",
            ft = { "sh", "javascript", "markdown", "lua", "python", "typescript", "vim" },
            cmd = { "ALEFix" },
            commit = "204e6294cfa0475e3437364d1c3dff6157fa1b83",
        })

        use({
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = [[require'config.treesitter']],
            run = ":TSUpdate",
            commit = "d7b7ca4a82fee1d3467e210afc02d9b184f625b4",
        })
        use({
            "vim-test/vim-test",
            commit = "01d1227ac49f32f97ff3993fd59a9f10c745c461",
        })
        use({
            knob = "dap",
            "nvim-telescope/telescope-dap.nvim",
            commit = "b4134fff5cbaf3b876e6011212ed60646e56f060",
        })
        use({
            "mfussenegger/nvim-dap",
            config = [[require'config.dap']],
            commit = "a9c49a5f9dc21e4e9359c2b7fe30ed3a2f65cd9a",
        })
        use({
            knob = "dap",
            "rcarriga/nvim-dap-ui",
            requires = "mfussenegger/nvim-dap",
            config = [[require'config.dapui']],
            commit = "e5c32746aa72e39267803fdf6934d79541d39f42",
        })
        use({
            "puremourning/vimspector",
            config = [[require'config.vimspector']],
            commit = "4e03d5ea5c2d7efb8d1f5e73dcc917ad53b0bfb9",
        })

        use({
            "ThePrimeagen/refactoring.nvim",
            commit = "ca2883162323a8d946bef43009f889f5d43917fe",
            config = [[require'config.refactoring']],
            requires = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-treesitter/nvim-treesitter" },
            },
        })

        use({
            "simrat39/symbols-outline.nvim",
            commit = "15ae99c27360ab42e931be127d130611375307d5",
            setup = [[require'config.symbols_outline']],
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
            commit = "5dc860aa939109a557aa03eec8f55d1ed1c921c0",
        })
        use({
            knob = "telescope",
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            commit = "2330a7eac13f9147d6fe9ce955cb99b6c1a0face",
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
            commit = "1a91238a6ad7a1f77fabdbee7225692a04b20d48",
        })

        use({
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.nvimtree']],
            cmd = { "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle" },
            commit = "9d6f4c184b5ce069d892c74a713dd44db7f0cf5e",
        })
        use({
            "ryanoasis/vim-devicons",
            commit = "a2258658661e42dd4cdba4958805dbad1fe29ef4",
        })
        use({ "wfxr/minimap.vim", cmd = { "Minimap" }, commit = "5d44fe7a3a5f7041c4220a71e8fe83d8c8498042" })
        use({
            "folke/which-key.nvim",
            event = "BufWinEnter",
            config = [[require'config.which_key']],
            commit = "bd4411a2ed4dd8bb69c125e339d837028a6eea71",
        })
        use({
            "phaazon/hop.nvim",
            config = [[require'config.hop']],
            commit = "b93ed4cea9c7df625d04e41cb15370b5c43cb578",
        })
        use({
            "ggandor/lightspeed.nvim",
            commit = "c5b93fc1d76a708cb698417326e04f4786a38d90",
        })
        use({
            "christoomey/vim-tmux-navigator",
            commit = "9ca5bfe5bd274051b5dd796cc150348afc993b80",
        })

        use({
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            config = [[require'config.lualine']],
            commit = "d64152cf5c79588e59d9349972b9284c28945405",
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
            commit = "a6db77965a27ca893ea693d69cc3c152c000a627",
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
        use({
            "p00f/nvim-ts-rainbow",
            after = "nvim-treesitter",
            config = [[require'config.rainbow']],
            commit = "190f8c83abb29504877b91c84ed3ceb6009ad3bd",
        })

        -- Git
        use({
            "tpope/vim-fugitive",
            cmd = { "G", "Git", "Gstatus", "Gblame", "Ggrep", "Gpush", "Gpull" },
            commit = "5b62c75238bf04b3156ffe62f821930827de8578",
        })
        use({
            "rbong/vim-flog",
            commit = "47123282f501fc77965e1d3c08357209d991c7f4"
        })
        use({
            "tpope/vim-rhubarb",
            cmd = { "GBrowse" },
            commit = "ab0d42bb31b3317aa66dd1c0b506837cc6ca2835",
        })
        use({
            "airblade/vim-gitgutter",
            commit = "719d4ec06a0fb0aa9f1dfaebcf4f9691e8dc3f73",
        })
        use({
            "akinsho/git-conflict.nvim",
            config = [[require'config.git_conflict']],
            commit = "8b7ce8839e2aaa847d2d2f2dca0e8e2f62f1d356",
        })
        use({
            "tpope/vim-dispatch",
            commit = "00e77d90452e3c710014b26dc61ea919bc895e92",
        })
        use({
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = [[require'config.gitsigns']],
            commit = "32763586ab9e2c0ec477e165bec5b382d0a1c266",
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
            commit = "aea913109d30c87df329ec9b8fea9aed6ef9f52a",
        })
        use({
            "tpope/vim-surround",
            commit = "bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea",
        })
        use({
            "tpope/vim-commentary",
            commit = "3654775824337f466109f00eaf6759760f65be34",
        })
        use({
            "tpope/vim-unimpaired",
            commit = "98427183e2b35acee15c7628b1cd587b98025719",
        })
        use({
            "tpope/vim-repeat",
            commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a",
        })
        use({
            "tpope/vim-abolish",
            commit = "3f0c8faadf0c5b68bcf40785c1c42e3731bfa522",
        })
        use({ "godlygeek/tabular", cmd = { "Tabularize" }, command = "339091ac4dd1f17e225fe7d57b48aff55f99b23a" })
        use({
            "editorconfig/editorconfig-vim",
            commit = "a8e3e66deefb6122f476c27cee505aaae93f7109",
        })
        use({
            "chrisbra/unicode.vim",
            commit = "176963d8e43dd54ff1582cb2374e731b51a7f5d5",
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
            "renerocksai/telekasten.nvim",
            config = [[require'config.telekasten']],
            commit = "c0925f0d301901d6c82c0ff6c8cc82a091463c8b",
        })

        use({
            "ellisonleao/glow.nvim",
            cmd = { "Glow" },
            commit = "da265c328f5e4f102dbdbb1a0fd8627afdaf0320",
        })
        use({
            "iamcco/markdown-preview.nvim",
            -- cmd = {"MarkdownPreview"},
            run = "cd app && yarn install",
            commit = "02cc3874738bc0f86e4b91f09b8a0ac88aef8e96",
        })
        use({
            "lukas-reineke/indent-blankline.nvim",
            commit = "8567ac8ccd19ee41a6ec55bf044884799fa3f56b",
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
            commit = "4aa4f40c350dbd17bd2035abbbc0e3a23f59e747",
        })
        use({
            "tpope/vim-eunuch",
            commit = "39e0232f490322c5a2d9e24275872f28da496a93",
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
