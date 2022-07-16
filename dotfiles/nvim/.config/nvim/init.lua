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
    editorconfig = 9,
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
    tpipeline = 9,
    treesitter = 3,
    trouble = 5,
    twightlight = 9,
    ufo = 9,
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

        require("config.config")

        use("wbthomason/packer.nvim")
        use("ianhomer/knobs.vim")

        -- LSP, autocomplete and code guidance
        _use({
            "neovim/nvim-lspconfig",
            config = [[require'config.lspconfig']],
            commit = "0da8c129dc27e70770c3247c44988bbf0af6b1af",
        })
        use({
            "weilbith/nvim-code-action-menu",
            cmd = "CodeActionMenu",
            commit = "ee599409ed6ab31f6d7115e9c5c4550336470c14",
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
            commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323",
        })

        _use({
            "hrsh7th/cmp-path",
            commit = "981baf9525257ac3269e1b6701e376d6fbff6921",
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
            commit = "007dd2740d9b70f2688db01a39d6d25b7169cd57",
        })

        _use({
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            commit = "c3f0086ed9882e52e0ae38dd5afa915f69054941",
        })

        _use({
            "hrsh7th/nvim-cmp",
            requires = "hrsh7th/cmp-buffer",
            config = [[require'config.cmp']],
            commit = "9897465a7663997b7b42372164ffc3635321a2fe",
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
            commit = "0e516c9d9892d6bf268492136971d315dd704d16",
        })

        use({
            "j-hui/fidget.nvim",
            commit = "46d1110435f1f023c22fa95bb10b3906aecd7bde",
            config = [[require'fidget'.setup{}]],
        })

        use({
            "kosayoda/nvim-lightbulb",
            config = [[require'config.lightbulb']],
            commit = "1e2844b68a07d3e7ad9e6cc9a2aebc347488ec1b",
        })

        use({
            "jose-elias-alvarez/null-ls.nvim",
            config = [[require'config.null_ls']],
            commit = "ec7764eb86bdae2f3a8fe31624aad67b8d814c71",
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
            commit = "f5e7f60e91821ca4e63d60fdc3a1428118ed1557",
            config = [[require'config.bqf']],
        })

        use({
            "majutsushi/tagbar",
            cmd = "TagbarToggle",
            config = [[require'config.tagbar']],
            commit = "0243b19920a683df531f19bb7fb80c0ff83927dd",
        })

        use({
            "folke/lsp-colors.nvim",
            commit = "517fe3ab6b63f9907b093bc9443ef06b56f804f3",
        })

        use({
            "dense-analysis/ale",
            ft = { "sh", "javascript", "markdown", "lua", "python", "typescript", "vim" },
            cmd = { "ALEFix" },
            commit = "5ef26c32da4407ca820afe359f6b957dd514a656",
        })

        use({
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = [[require'config.treesitter']],
            run = ":TSUpdate",
            commit = "3bd228781bf4a927c5ceaf7a4687fed9f96d12b5",
        })
        use({
            "vim-test/vim-test",
            commit = "f20a5572d310051dbd1a258740833bca27a106a6",
        })
        use({
            knob = "dap",
            "nvim-telescope/telescope-dap.nvim",
            commit = "b4134fff5cbaf3b876e6011212ed60646e56f060",
        })
        use({
            "mfussenegger/nvim-dap",
            config = [[require'config.dap']],
            commit = "b9328b0cbd4dcbab29b1ce68f7103fe86a7703e1",
        })
        use({
            knob = "dap",
            "rcarriga/nvim-dap-ui",
            requires = "mfussenegger/nvim-dap",
            config = [[require'config.dapui']],
            commit = "d33b905770f9c674468b0b83bed3aeab41cf9bb0",
        })
        use({
            "puremourning/vimspector",
            config = [[require'config.vimspector']],
            commit = "4e68dc10ba00a4990090872dce2b15127e28fe55",
        })

        use({
            "ThePrimeagen/refactoring.nvim",
            commit = "b11ca3574c85c98e07e4d5f8c47e38bacbbda34f",
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
            commit = "c311c0a95fc2529c26ab36a8f530e9dd4426304c",
        })
        use({
            "nvim-lua/plenary.nvim",
            commit = "986ad71ae930c7d96e812734540511b4ca838aa2",
        })
        use({
            knob = "telescope",
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            commit = "6a33ecefa9b3d9ade654f9a7a6396a00c3758ca6",
        })
        use({ knob = "frecency", "tami5/sqlite.lua", commit = "d53bdff134a81e12834c3f7bd431376482132b7c" })

        use({
            knob = "frecency",
            "nvim-telescope/telescope-frecency.nvim",
            after = { "sqlite.lua" },
            commit = "68ac8cfe6754bb656b4f84d6c3dafa421b6f9697",
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
            commit = "6bddc38c25af7b50f99cb0c035248d7272971810",
        })

        use({
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.nvimtree']],
            cmd = { "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle" },
            commit = "449b5bd0cbe08192ded83b2bce8cbec4764da63d",
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
            commit = "bd4411a2ed4dd8bb69c125e339d837028a6eea71",
        })
        use({
            "phaazon/hop.nvim",
            config = [[require'config.hop']],
            commit = "6bcaeb7c0ea30afe137db11fcf681c373a7171bf",
        })
        use({
            "ggandor/lightspeed.nvim",
            commit = "a4b4277d143270c6a7d85ef2e1574a1bbeab6677",
        })
        use({
            "christoomey/vim-tmux-navigator",
            commit = "9ca5bfe5bd274051b5dd796cc150348afc993b80",
        })

        use({
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            config = [[require'config.lualine']],
            commit = "655411fb7aa3cf4d46094132d684d815453f5043",
        })
        use({
            "vimpostor/vim-tpipeline",
            commit = "a3ef5c9018a9f834fe7ff6b82a9b613cdf81bef0",
        })
        use({
            "romgrk/barbar.nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
            config = [[require'config.barbar']],
            commit = "fa3ff258108bbffefb31beb2ae9af3c60ec9c190",
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
            commit = "a423ff33e9f9182cf6ee346ae19df2583ab37f55",
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
            commit = "54c5c419f6ee2b35557b3a6a7d631724234ba97a",
        })
        use({
            "p00f/nvim-ts-rainbow",
            after = "nvim-treesitter",
            config = [[require'config.rainbow']],
            commit = "9dd019e84dc3b470dfdb5b05e3bb26158fef8a0c",
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
            commit = "ff04324bffd86f9c146cc5fc2c0a2f95a1509643",
        })
        use({
            "rbong/vim-flog",
            commit = "fb137707b84a328d3f1b53d22894e3c52f4a6ddb",
        })
        use({
            "tpope/vim-rhubarb",
            cmd = { "GBrowse" },
            commit = "09b9b1ca86d3e55d4ed80770a053beaf9d2edbef",
        })
        use({
            "airblade/vim-gitgutter",
            commit = "ded11946c04aeab5526f869174044019ae9e3c32",
        })
        use({
            "akinsho/git-conflict.nvim",
            config = [[require'config.git_conflict']],
            commit = "80bc8931d4ed8c8c4d289a08e1838fcf4741408d",
        })
        use({
            "tpope/vim-dispatch",
            commit = "00e77d90452e3c710014b26dc61ea919bc895e92",
        })
        use({
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = [[require'config.gitsigns']],
            commit = "bb6c3bf6f584e73945a0913bb3adf77b60d6f6a2",
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
            commit = "972a7977e759733dd6721af7bcda7a67e40c010e",
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
        use({ "godlygeek/tabular", cmd = { "Tabularize" }, command = "339091ac4dd1f17e225fe7d57b48aff55f99b23a" })
        use({
            "editorconfig/editorconfig-vim",
            commit = "d354117b72b3b43b75a29b8e816c0f91af10efe9",
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
            commit = "67a6e917b8adae892fc661b68c4f3782ebf7ba2b",
        })

        use({
            "ellisonleao/glow.nvim",
            cmd = { "Glow" },
            commit = "764527caeb36cd68cbf3f6d905584750cb02229d",
        })
        use({
            "iamcco/markdown-preview.nvim",
            -- cmd = {"MarkdownPreview"},
            run = "cd app && yarn install",
            commit = "02cc3874738bc0f86e4b91f09b8a0ac88aef8e96",
        })
        use({
            "lukas-reineke/indent-blankline.nvim",
            commit = "4a58fe6e9854ccfe6c6b0f59abb7cb8301e23025",
        })
        use({
            "junegunn/vim-peekaboo",
            commit = "cc4469c204099c73dd7534531fa8ba271f704831",
        })
        use({
            "simnalamburt/vim-mundo",
            commit = "b9a6adbcfacc1ffe42ef3aa888f7c828a0b63746",
            cmd = { "MundoToggle" },
        })

        -- Misc

        use({
            "akinsho/toggleterm.nvim",
            cmd = { "ToggleTerm", "TermExec" },
            config = [[require'config.toggleterm']],
            commit = "91505816335a93b10f026409228aef5e8d48e6d9",
        })
        use({
            "tpope/vim-eunuch",
            commit = "74e0e1662cc9ed3d58ba3e3de20eb30ac4039956",
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
