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
    colorizer = 4,
    conflict_marker = 7,
    commentary = 4,
    compactcmd = 1,
    cmp = 4,
    dap = 9,
    defaults = 2,
    devicons = 4,
    dispatch = 4,
    editorconfig = 4,
    endwise = 7,
    eunuch = 3,
    fugitive = 3,
    friendly_snippets = 5,
    fzf = 9,
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
            commit = "531751ef03d77bf094f1fc07844b6c03ec4862bb",
        })
        use({
            "weilbith/nvim-code-action-menu",
            cmd = "CodeActionMenu",
            commit = "796d45f0ac89b9e5b6d41fb2c1fada25c1aba870",
        })
        _use({
            "onsails/lspkind-nvim",
            config = [[require("lspkind").init()]],
            commit = "f0d1552890e384f15b47ea88bd1b8a077cddc24a",
        })

        _use({
            "hrsh7th/cmp-nvim-lsp",
            commit = "ebdfc204afb87f15ce3d3d3f5df0b8181443b5ba",
        })

        _use({
            "hrsh7th/cmp-buffer",
            commit = "f83773e2f433a923997c5faad7ea689ec24d1785",
        })

        _use({
            "hrsh7th/cmp-path",
            commit = "c5230cb439df9547294678d0f1c1465ad7989e5f",
        })

        _use({
            "hrsh7th/cmp-cmdline",
            commit = "29ca81a6f0f288e6311b3377d9d9684d22eac2ec",
        })

        _use({
            "hrsh7th/cmp-nvim-lua",
            commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21",
        })

        _use({
            "hrsh7th/nvim-cmp",
            requires = "hrsh7th/cmp-buffer",
            config = [[require'config.cmp']],
            commit = "de69c657ebbb2fa1ed918b97f27733b801ee639c",
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
            commit = "7fde9c0b6878a62bcc6d2d29f9a85a6616032f02",
        })

        use({
            "kosayoda/nvim-lightbulb",
            config = [[require'config.lightbulb']],
            commit = "cd5267d2d708e908dbd668c7de74e1325eb1e1d",
        })

        use({
            "jose-elias-alvarez/null-ls.nvim",
            config = [[require'config.null_ls']],
            commit = "1ebe15833e93c15404db0c59a5ed5c5e4bfe07a2",
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
            commit = "dd2f46af80d614e3305847845c2a4a4b7447017",
        })

        use({
            "majutsushi/tagbar",
            cmd = "TagbarToggle",
            config = [[require'config.tagbar']],
            commit = "0441c1c6d9b39249503bc816c7a4e5895f72729e",
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
            commit = "3cfbde4db05dc9f3f38fcee212849799bb6f2e54",
        })
        use({
            knob = "dap",
            "nvim-telescope/telescope-dap.nvim",
            commit = "b4134fff5cbaf3b876e6011212ed60646e56f06",
        })
        use({
            "mfussenegger/nvim-dap",
            config = [[require'config.dap']],
            commit = "a6fa644f9de62c594a8a9cf6f2aaf324b5a6108b",
        })
        use({
            knob = "dap",
            "rcarriga/nvim-dap-ui",
            requires = "mfussenegger/nvim-dap",
            config = [[require'config.dapui']],
            commit = "96813c9a42651b729f50f5d880a8919a155e9721",
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
            requires = { { "junegunn/fzf", opt = true, fn = { "fzf#shellescape" } } },
            commit = "d6aa21476b2854694e6aa7b0941b8992a906c5e",
        })
        use({
            "nvim-lua/plenary.nvim",
            commit = "563d9f6d083f0514548f2ac4ad1888326d0a1c66",
        })
        use({
            knob = "telescope",
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            commit = "b8662b076175e75e6497c59f3e2799b879d7b954",
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
            },
            config = [[require'config.telescope']],
            commit = "f262e7d56d37625613c5de0df5a933cccacf13c5",
        })
        use({
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.nvimtree']],
            cmd = { "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle" },
            commit = "99d65afd6ef05cc57f835451126e5c44db03cef1",
        })
        use({
            "ryanoasis/vim-devicons",
            commit = "9252538fedd6bed5c7eff20ee6f9593676e2fed4",
        })
        use({ "wfxr/minimap.vim", cmd = { "Minimap" }, commit = "ff25e21888bc8cd7b2981a0964d91057e552674f" })
        use({
            "folke/which-key.nvim",
            event = "BufWinEnter",
            config = [[require'config.which_key']],
            commit = "28d2bd129575b5e9ebddd88506601290bb2bb221",
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
            commit = "70691ae350fdbe1f15758e3b8e2973742a7967a9",
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
            commit = "e308a9e5e8b527d646bf485b9148db894a617560",
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
            commit = "a93ceff61f070a095c3c712c389247a80897e3b0",
        })
        use({
            "tpope/vim-rhubarb",
            cmd = { "GBrowse" },
            commit = "977b3ccbad1f7e5370354ae409fb2ea4a7ce2058",
        })
        use({
            "airblade/vim-gitgutter",
            commit = "256702dd1432894b3607d3de6cd660863b331818",
        })
        use({
            "tpope/vim-dispatch",
            commit = "527f200fb86c18d1cc7dc702d13f8818dced04ac",
        })
        use({
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = [[require'config.gitsigns']],
            commit = "c18fc65c77abf95ac2e7783b9e7455a7a2fab26c",
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
            commit = "0f8df7e43f0cae4c44e0e8383436ad602f333419",
        })
        use({
            "junegunn/vim-peekaboo",
            commit = "cc4469c204099c73dd7534531fa8ba271f704831",
        })

        -- Misc

        use({
            "akinsho/toggleterm.nvim",
            cmd = { "ToggleTerm", "TermExec" },
            config = [[require'config.toggleterm']],
            commit = "f23866b8fbb0703be4e15d50c814ffe496242a67",
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
