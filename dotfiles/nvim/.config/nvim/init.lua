local cmd = vim.cmd
local g = vim.g
local o = vim.o
local nvim_set_var = vim.api.nvim_set_var

vim.opt.shell = "/bin/bash"

local ok, _ = pcall(require, "impatient")
if ok then
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
    trouble = 6,
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

        use("lewis6991/impatient.nvim")

        local ok, knobs = pcall(require, "knobs")
        use = ok and knobs.use(_use) or _use

        use("wbthomason/packer.nvim")
        use("ianhomer/knobs.vim")

        -- LSP, autocomplete and code guidance
        _use({
            "neovim/nvim-lspconfig",
            config = [[require'config.lspconfig']],
            commit = "3d1baa811b351078e5711be1a1158e33b074be9e",
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
            commit = "15f08a8faa22d52480cdcb9ef9ca698120f04363",
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
            "j-hui/fidget.nvim",
            commit = "d47f2bbf7d984f69dc53bf2d37f9292e3e99ae8a",
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
            commit = "0292b2283f6fdf6cd4f954219f97b1ab7d6df5a5",
            requires = { "nvim-lua/plenary.nvim" },
        })

        use({
            cmd = "Vista",
            "liuchengxu/vista.vim",
            commit = "a0469c645dcbe4033b857da27d35491f39e2f77",
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
            commit = "1605c89e3c13d8412313b8138cc28c1a63cc0fb1",
            config = [[require'config.bqf']],
        })

        use({
            "majutsushi/tagbar",
            cmd = "TagbarToggle",
            config = [[require'config.tagbar']],
            commit = "2137c1437012afc82b5d50404b1404aec8699f7b",
        })

        use({
            "folke/lsp-colors.nvim",
            commit = "517fe3ab6b63f9907b093bc9443ef06b56f804f3",
        })

        use({
            "dense-analysis/ale",
            ft = { "sh", "javascript", "markdown", "lua", "python", "typescript", "vim" },
            cmd = { "ALEFix" },
            commit = "48f68598cb49c5711f31d9ed204a4f0fdc390330",
        })

        use({
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = [[require'config.treesitter']],
            run = ":TSUpdate",
            commit = "b474ad19d54f43bd1c78c7f669cbd0dd4f09ec11",
        })
        use({
            "vim-test/vim-test",
            commit = "56bbfa295fe62123d2ebe8ed57dd002afab46097",
        })
        use({
            knob = "dap",
            "nvim-telescope/telescope-dap.nvim",
            commit = "b4134fff5cbaf3b876e6011212ed60646e56f060",
        })
        use({
            "mfussenegger/nvim-dap",
            config = [[require'config.dap']],
            commit = "e6d7ba5847fbe5f33ba211cf28d3cea72cfa9865",
        })
        use({
            knob = "dap",
            "rcarriga/nvim-dap-ui",
            requires = "mfussenegger/nvim-dap",
            config = [[require'config.dapui']],
            commit = "33f33dfced1d7d98e2b934bd663175a062d8db39",
        })
        use({
            "puremourning/vimspector",
            config = [[require'config.vimspector']],
            commit = "c0fbf1e54d1928e3c3df7e99e844b69a79a29555",
        })

        -- Navigation

        use({ "mhinz/vim-startify", commit = "81e36c352a8deea54df5ec1e2f4348685569bed2" })
        use({
            "junegunn/fzf.vim",
            cmd = { "Ag", "Buffers", "Commits", "Files", "History" },
            fn = { "fzf#vim#ag" },
            ft = { "qf" },
            requires = { { "junegunn/fzf", opt = true, fn = { "fzf#shellescape" }, ft = { "qf" } } },
            commit = "b23e4bb8f853cb9641a609c5c8545751276958b0",
        })
        use({
            "nvim-lua/plenary.nvim",
            commit = "cbaeb9fffc14e7e5687715987a94b4f410084560",
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
            commit = "d38ad438f3bb4e3721b9964172c8c9d70d5d06a8",
        })

        use({
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.nvimtree']],
            cmd = { "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle" },
            commit = "5958fd5d068877fbf3d083abff03dccb4d8286a1",
        })
        use({
            "ryanoasis/vim-devicons",
            commit = "a2258658661e42dd4cdba4958805dbad1fe29ef4",
        })
        use({ "wfxr/minimap.vim", cmd = { "Minimap" }, commit = "ff25e21888bc8cd7b2981a0964d91057e552674f" })
        use({
            "folke/which-key.nvim",
            event = "BufWinEnter",
            config = [[require'config.which_key']],
            commit = "a3c19ec5754debb7bf38a8404e36a9287b282430",
        })
        use({
            "phaazon/hop.nvim",
            config = [[require'config.hop']],
            commit = "235ca561e1074da53858fa6f9f706cb4bfff0dc3",
        })
        use({
            "christoomey/vim-tmux-navigator",
            commit = "9ca5bfe5bd274051b5dd796cc150348afc993b80",
        })

        -- Note that hoob3rt has stagnated and shadmansaleh continues ...
        use({
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            config = [[require'config.lualine']],
            commit = "7345986fb43c054c9ab2a7d231c5891f58cc6d37",
        })
        use({
            "romgrk/barbar.nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
            config = [[require'config.barbar']],
            commit = "6e638309efcad2f308eb9c5eaccf6f62b794bbab",
        })

        -- Style
        use({
            "morhetz/gruvbox",
            commit = "bf2885a95efdad7bd5e4794dd0213917770d79b7",
        })
        use({
            "lifepillar/gruvbox8",
            commit = "1e205910e67003ff9efb77e7730f1e49d8aae29c",
        })
        use({
            "rebelot/kanagawa.nvim",
            commit = "f5881a688b951cb35a7f36628b23ee4393d96daf",
            config = [[vim.cmd("colorscheme kanagawa")]],
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
            commit = "c0701f7a0e92b571198c65de40025e67aaaac64b",
        })
        use({
            "tpope/vim-rhubarb",
            cmd = { "GBrowse" },
            commit = "977b3ccbad1f7e5370354ae409fb2ea4a7ce2058",
        })
        use({
            "airblade/vim-gitgutter",
            commit = "18d12985ea6cb7ede59755ff4fd0a9fa1e6bf835",
        })
        use({
            "tpope/vim-dispatch",
            commit = "00e77d90452e3c710014b26dc61ea919bc895e92",
        })
        use({
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = [[require'config.gitsigns']],
            commit = "5c487a804e462c284c159c800a803b8e0294d0a4",
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
            commit = "a9b6b98de3bacacc0c986d9b0673cae6a87c4a41",
        })
        use({
            "tpope/vim-surround",
        })
        use("tpope/vim-commentary")
        use("tpope/vim-unimpaired")

        use("tpope/vim-repeat")
        use({ "godlygeek/tabular", cmd = { "Tabularize" }, command = "339091ac4dd1f17e225fe7d57b48aff55f99b23a" })

        use({
            "editorconfig/editorconfig-vim",
            commit = "3078cd10b28904e57d878c0d0dab42aa0a9fdc89",
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
            commit = "d86281307ce2898d0fcd85ecb0865fc1dd2f2578",
        })
        use({
            "iamcco/markdown-preview.nvim",
            -- cmd = {"MarkdownPreview"},
            run = "cd app && yarn install",
            commit = "e5bfe9b89dc9c2fbd24ed0f0596c85fd0568b143",
        })
        use({
            "lukas-reineke/indent-blankline.nvim",
            commit = "9920ceb79bffd0e6b7064be63439e38da0741d03",
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
            commit = "9f969e7f72d19966756318d61f2562f67dbb1f9c",
        })
        use({
            "tpope/vim-eunuch",
            commit = "7a48f9ff0ef5f21447b2354ee52dc18b5567e05c",
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
