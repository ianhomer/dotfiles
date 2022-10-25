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
    minimap = 5,
    modes = 3,
    mundo = 3,
    neoscroll = 3,
    neotest = 9,
    nnn = 9,
    notify = 5,
    null_ls = 3,
    nvim_tree = 3,
    peekaboo = 9,
    rainbow = 3,
    refactoring = 9,
    rhubarb = 7,
    shortcuts = 3,
    sleuth = 3,
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

require("config/kitty")

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
            commit = "03f4f942dd3b3ec060d5826782ba2efd87026242",
        })
        -- LSP, autocomplete and code guidance
        use({
            "neovim/nvim-lspconfig",
            event = "BufWinEnter",
            config = [[require'config.lspconfig']],
            commit = "334cc8601ce5f04384ebe79527284fd177938412",
        })
        use({
            "weilbith/nvim-code-action-menu",
            cmd = "CodeActionMenu",
            commit = "ee599409ed6ab31f6d7115e9c5c4550336470c14",
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
            commit = "f33bc99d0ed3ed691a58b3339decf4e1933c3f9e",
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
            "hrsh7th/cmp-nvim-lsp-signature-help",
            commit = "3dd40097196bdffe5f868d5dddcc0aa146ae41eb",
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
            commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36",
        })

        _use({
            knob = "luasnip",
            "L3MON4D3/LuaSnip",
            requires = { "saadparwaiz1/cmp_luasnip" },
            commit = "563827f00bb4fe43269e3be653deabc0005f1302",
        })

        _use({
            "hrsh7th/nvim-cmp",
            requires = "hrsh7th/cmp-buffer",
            config = [[require'config.cmp']],
            commit = "714ccb7483d0ab90de1b93914f3afad1de8da24a",
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
            commit = "1097a86db8ba38e390850dc4035a03ed234a4673",
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
            commit = "643c67a296711ff40f1a4d1bec232fa20b179b90",
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
            commit = "af935fd8329ba67d96afa1b2650af84251f1dc0a",
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
            commit = "c33b5c57ff82d71f8004b37c8c17a7928da76d08",
            config = [[require'config.bqf']],
        })

        use({
            "majutsushi/tagbar",
            cmd = "TagbarToggle",
            config = [[require'config.tagbar']],
            commit = "83933d557409639df53fd2ca21484279b5854c1e",
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
            commit = "d3ca4de41faf996258b72924ecb1ecc2df69846e",
        })

        use({
            knob = "treesitter",
            "nvim-treesitter/nvim-treesitter-textobjects",
            config = [[require'config.treesitter_textobjects']],
            commit = "3c394d8e5268efdc49c6c728502bca8121859a70",
        })

        use({
            "preservim/vimux",
            commit = "616fcb4799674a7a809b14ca2dc155bb6ba25788",
        })
        use({
            "vim-test/vim-test",
            commit = "e7150de777ef0c81a015972e4feb56c4b3137efd",
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
            commit = "272a22b6b48c4e5f6b0fc0b0bd3d0c519e620231",
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
            commit = "6b12294a57001d994022df8acbe2ef7327d30587",
        })
        use({
            knob = "dap",
            "rcarriga/nvim-dap-ui",
            requires = "mfussenegger/nvim-dap",
            config = [[require'config.dapui']],
            commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13",
        })
        use({
            "puremourning/vimspector",
            config = [[require'config.vimspector']],
            commit = "2e309e74c16700cfc5e2c32541e29b95f0a5bdd3",
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
            commit = "f174a0367b4fc7cb17710d867e25ea792311c418",
        })

        use({
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.nvimtree']],
            cmd = { "NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle" },
            commit = "b07701f9da3ec62016ad46002a6c0ae9b414574c",
        })
        _use({
            "ryanoasis/vim-devicons",
            commit = "71f239af28b7214eebb60d4ea5bd040291fb7e33",
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
            commit = "6591b3656b75ff313cc38dc662a7ee8f75f1c165",
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
            commit = "edca2b03c724f22bdc310eee1587b1523f31ec7c",
        })
        use({
            "vimpostor/vim-tpipeline",
            commit = "9b68ba0bc30d0ddf54ea789496d39c656c8745e1",
        })
        use({
            "romgrk/barbar.nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
            config = [[require'config.barbar']],
            commit = "517b457630d84aff875287d8249791df95ff91ab",
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
            commit = "9dd7ecde55b06b5114e1fa67c522433e7e59db8b",
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
            commit = "1ec3f880585c644ddd50a51502c59f4e36f03e62",
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
            commit = "2c6f96dda47e55fa07052ce2e2141e8367cbaaf2",
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
            commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347",
        })
        use({
            "tpope/vim-surround",
            commit = "bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea",
        })
        use({
            "tpope/vim-sleuth",
            commit = "8332f123a63c739c870c96907d987cc3ff719d24",
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
            commit = "12b808a6867e8c38015488ad6cee4e3d58174182",
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
            commit = "923274dfb827b5a13996ac16c4374632be95cf6a",
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
