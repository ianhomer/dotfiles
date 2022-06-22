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

        require"config.config"

        use("wbthomason/packer.nvim")
        use("ianhomer/knobs.vim")

        -- LSP, autocomplete and code guidance
        _use({
            "neovim/nvim-lspconfig",
            config = [[require'config.lspconfig']],
            commit = "689bdccf4f5ca036e3792e0f77f451553d33af0c",
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
            commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a",
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
            commit = "ff40739e5be6581899b43385997e39eecdbf9465",
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
            commit = "2f0d77df708074912b91deb95e3d090f866f289f",
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
            commit = "f10349b48b173d50b523ce009934bb4bfba04f7f",
        })

        use({
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = [[require'config.treesitter']],
            run = ":TSUpdate",
            commit = "518e27589c0463af15463c9d675c65e464efc2fe",
        })
        use({
            "vim-test/vim-test",
            commit = "ee81a7a50c684298b0eb12bcbdef8cfe3eb1f515",
        })
        use({
            knob = "dap",
            "nvim-telescope/telescope-dap.nvim",
            commit = "b4134fff5cbaf3b876e6011212ed60646e56f060",
        })
        use({
            "mfussenegger/nvim-dap",
            config = [[require'config.dap']],
            commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d",
        })
        use({
            knob = "dap",
            "rcarriga/nvim-dap-ui",
            requires = "mfussenegger/nvim-dap",
            config = [[require'config.dapui']],
            commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7",
        })
        use({
            "puremourning/vimspector",
            config = [[require'config.vimspector']],
            commit = "b33b1be7679efb756c88ad398f6e7d77505c02c6",
        })

        use({
            "ThePrimeagen/refactoring.nvim",
            commit = "802667c9b8da79678a78cb10bc0286e8a2644e8d",
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
            commit = "968a4b9afec0c633bc369662e78f8c5db0eba249",
        })
        use({
            knob = "telescope",
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            commit = "6a33ecefa9b3d9ade654f9a7a6396a00c3758ca6",
        })
        use({ knob = "frecency", "tami5/sqlite.lua", commit = "07f64ac0efbcd88af286501f7e0d8e37f97638ff" })

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
            commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0",
        })

        use({
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.nvimtree']],
            cmd = { "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle" },
            commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243",
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
            commit = "03675eba34d416dd22ad49b2d0e52b6113b434ad",
        })
        use({
            "ggandor/lightspeed.nvim",
            commit = "ae47dfd4b8c58b590ad8491b4fe97b88e51b4b1d",
        })
        use({
            "christoomey/vim-tmux-navigator",
            commit = "9ca5bfe5bd274051b5dd796cc150348afc993b80",
        })

        use({
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            config = [[require'config.lualine']],
            commit = "3362b28f917acc37538b1047f187ff1b5645ecdd",
        })
        use({
            "romgrk/barbar.nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
            config = [[require'config.barbar']],
            commit = "6222ad5a5242daaade26babb4090a41e23317952",
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
            commit = "76df2251e813fdec244b2b593be62accea930119",
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
            commit = "71c8fadd60362383e5e817e95f64776f5e2737d8",
        })
        use({
            "p00f/nvim-ts-rainbow",
            after = "nvim-treesitter",
            config = [[require'config.rainbow']],
            commit = "18cb3a45e0ff843d48e8637a36b9cc6cd89d71b0",
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
            commit = "6ae79e75a44ac3acb88f381ed52898c9f9e01d62",
        })
        use({
            "rbong/vim-flog",
            commit = "47123282f501fc77965e1d3c08357209d991c7f4",
        })
        use({
            "tpope/vim-rhubarb",
            cmd = { "GBrowse" },
            commit = "f8b70f5ef3b315af1148ef9dcc2a9afb02bc8c79",
        })
        use({
            "airblade/vim-gitgutter",
            commit = "ded11946c04aeab5526f869174044019ae9e3c32",
        })
        use({
            "akinsho/git-conflict.nvim",
            config = [[require'config.git_conflict']],
            commit = "a8abdc59603516e1d45eb78d511efa40c6035bdc",
        })
        use({
            "tpope/vim-dispatch",
            commit = "00e77d90452e3c710014b26dc61ea919bc895e92",
        })
        use({
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = [[require'config.gitsigns']],
            commit = "c18e016864c92ecf9775abea1baaa161c28082c3",
        })
        use({
            "junegunn/gv.vim",
            cmd = { "GV" },
            commit = "0d9e787246caed6c22128c05efed9e9fc65ca4cf",
        })
        -- Editing
        use({
            "windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = [[require'config.autopairs']],
            commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec",
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
            commit = "440033919e89709ed592c585c0a876e292258d62",
        })

        use({
            "ellisonleao/glow.nvim",
            cmd = { "Glow" },
            commit = "900042f7dda528cb980b7f1056ed7c21d4402826",
        })
        use({
            "iamcco/markdown-preview.nvim",
            -- cmd = {"MarkdownPreview"},
            run = "cd app && yarn install",
            commit = "02cc3874738bc0f86e4b91f09b8a0ac88aef8e96",
        })
        use({
            "lukas-reineke/indent-blankline.nvim",
            commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2",
        })
        use({
            "junegunn/vim-peekaboo",
            commit = "cc4469c204099c73dd7534531fa8ba271f704831",
        })
        use({
            "simnalamburt/vim-mundo",
            commit = "4cc954f5cad7ebf6c20b652c6cd6966940752b5b",
            cmd = { "MundoToggle" },
        })

        -- Misc

        use({
            "akinsho/toggleterm.nvim",
            cmd = { "ToggleTerm", "TermExec" },
            config = [[require'config.toggleterm']],
            commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8",
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
