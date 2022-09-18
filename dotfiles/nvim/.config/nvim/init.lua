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
    cmp = 5,
    dap = 6,
    defaults = 2,
    devicons = 4,
    dispatch = 4,
    document_color = 9,
    easy_align = 3,
    editorconfig = 9,
    endwise = 7,
    eunuch = 3,
    fidget = 3,
    flog = 9,
    fugitive = 3,
    frecency = 9,
    friendly_snippets = 5,
    fzf = 6,
    git_conflict = 9,
    gitgutter = 6,
    gitsigns = 5,
    gruvbox = 9,
    gruvbox8 = 9,
    glow = 3,
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
    lightspeed = 5,
    lsp = 4,
    lsp_colors = 9,
    lspconfig = 4,
    lspkind = 4,
    lsp_signature = 6,
    lspsaga = 9,
    lualine = 3,
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
    rainbow = 5,
    refactoring = 5,
    rhubarb = 7,
    shortcuts = 1,
    spelling = 5,
    startify = 4,
    startuptime = 1,
    surround = 3,
    symbols_outline = 9,
    tabcomplete = 9,
    tabular = 3,
    telescope = 5,
    telescope_fzf_native = 5,
    telescope_symbols = 5,
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
    vsnip = 3,
    vimux = 5,
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
        _use({
            "antoinemadec/FixCursorHold.nvim",
            commit = "5aa5ff18da3cdc306bb724cf1a138533768c9f5e",
        }) -- fixes https://github.com/neovim/neovim/issues/12587

        local ok, knobs = pcall(require, "knobs")
        local use = ok and knobs.use(_use) or _use

        require("config.config")

        use("wbthomason/packer.nvim")
        use("ianhomer/knobs.vim")

        -- LSP, autocomplete and code guidance
        use({
            "neovim/nvim-lspconfig",
            event = "BufWinEnter",
            config = [[require'config.lspconfig']],
            commit = "8e65dbb6e187604cdaf0e0ef2e90c790760912e7",
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

        use({
            "glepnir/lspsaga.nvim",
            event = "BufWinEnter",
            config = [[require'config.lspsaga']],
            commit = "db209940a471aff4bf36e501e56a51fc6a861e63",
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
            commit = "9c0e331fe78cab7ede1c051c065ee2fc3cf9432e",
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
            commit = "22a99756492a340c161ab122b0ded90ab115a1b3",
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
            commit = "4342844954e89bca0e93a8057538000b7a9b737d",
            requires = { "nvim-lua/plenary.nvim" },
        })

        use({
            cmd = "Vista",
            "liuchengxu/vista.vim",
            commit = "f9c8c8ad4135346a945e1ebfb00b723976d92dfc",
        })

        use({
            "rcarriga/nvim-notify",
            config = [[require'config.notify']],
            commit = "7076ce8e8f042e193668b7ac67f776858df5206b",
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
            commit = "aac1ff94a8b411a08810117f41e948743a4df69e",
            config = [[require'config.bqf']],
        })

        use({
            "majutsushi/tagbar",
            cmd = "TagbarToggle",
            config = [[require'config.tagbar']],
            commit = "87afc291ee5250debbbfe0ad0016f24d1eb296a6",
        })

        use({
            "folke/lsp-colors.nvim",
            commit = "4e6da1984d23da88a947805866580c48fc3cc8d7",
        })

        use({
            "dense-analysis/ale",
            ft = { "sh", "javascript", "markdown", "lua", "python", "typescript", "vim" },
            cmd = { "ALEFix" },
            commit = "477ad3fdd2df80a9dc479f974caeca1aa6ae640b",
        })

        use({
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = [[require'config.treesitter']],
            run = ":TSUpdate",
            commit = "557123a6168936983d7b980df195057ca6b370ed",
        })

        use({
          knob = "treesitter",
          "nvim-treesitter/nvim-treesitter-textobjects",
          config = [[require'config.treesitter_textobjects']],
          commit = "e63c2ff8e38fad77299dd74e14c7c9360e1b3181"
        })

        use({
            "preservim/vimux",
            commit = "740320b798106c5de6758fb35bf39e79ee1ce0f0",
        })
        use({
            "vim-test/vim-test",
            commit = "2fb195d100cd48fe1ae34e8683c919f34d80247b",
        })
        use({
            knob = "neotest",
            "nvim-neotest/neotest-vim-test",
            commit = "f95a60d89be8c7098d33306c1d13b412c4c21f9d",
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
            commit = "a52052c06e737647cc79fc7bc04a7d76f46daeab",
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
            commit = "d9b315a81622457cddf6875c6ac7134baa9932ce",
        })
        use({
            knob = "dap",
            "rcarriga/nvim-dap-ui",
            requires = "mfussenegger/nvim-dap",
            config = [[require'config.dapui']],
            commit = "ce8894c586e904ce0d00fcae1a7124132810a206",
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
            requires = { { "junegunn/fzf", opt = true, fn = { "fzf#shellescape" }, ft = { "qf" } } },
            commit = "c491d702b76c6b4918abb80be3cfb57d1b618ffa",
        })
        use({
            "nvim-lua/plenary.nvim",
            commit = "4b66054e75356ac0b909bbfee9c682e703f535c2",
        })
        use({
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            commit = "65c0ee3d4bb9cb696e262bca1ea5e9af3938fc90",
        })
        use({ knob = "frecency", "tami5/sqlite.lua", commit = "56c5aacd5e31496d9b3cd3d1b0e570bb9a65d35b" })

        use({
            knob = "frecency",
            "nvim-telescope/telescope-frecency.nvim",
            after = { "sqlite.lua" },
            commit = "d51c7631dcc0f598692676f554c4e79d7596d541",
        })

        use({
            "nvim-telescope/telescope-symbols.nvim",
            commit = "f7d7c84873c95c7bd5682783dd66f84170231704",
        })
        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                { "nvim-lua/popup.nvim", cond = "vim.g['knob_telescope']" },
                { "nvim-lua/plenary.nvim", cond = "vim.g['knob_telescope']" },
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    cond = "vim.g['knob_telescope_fzf_native']",
                },
                { "nvim-telescope/telescope-symbols.nvim", cond = "vim.g['knob_telescope_symbols']" },
                { "nvim-telescope/telescope-frecency.nvim", cond = "vim.g['knob_frecency']" },
            },
            config = [[require'config.telescope']],
            commit = "2584ff391b528d01bf5e8c04206d5902a79ebdde",
        })

        use({
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.nvimtree']],
            cmd = { "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle" },
            commit = "fb8735e96cecf004fbefb086ce85371d003c5129",
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
            commit = "439637d6a75fe27e369190df7910ed2a454109f6",
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
            commit = "3cf45404d4ab5e3b5da283877f57b676cb78d41d",
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
            commit = "0c7fb04a3d0e99c2f7e401c687e9c52b2b49a95c",
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
            commit = "bce44d82719ca196d938ba6c68294b55f8ba359c",
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
            commit = "d7e0bcbe45bd9d5d106a7b2e11dc15917d272c7a",
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
            commit = "5fe24419e7a7ec536d78d60be1515b018ab41b15",
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
        _use({
            "stevearc/dressing.nvim",
            commit = "b188b7750c78c0dbe0c61d79d824673a53ff82db",
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
            commit = "5e393e558f7c41d132542c8e9626aa824a1caa59",
        })
        use({
            "tpope/vim-eunuch",
            commit = "63da2dd64c040abc02b24b6a4679e0b7ff35be29",
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
