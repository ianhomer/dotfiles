local cmd = vim.cmd
local g = vim.g
local o = vim.o
local nvim_set_var = vim.api.nvim_set_var

vim.opt.shell = "/bin/bash"

--local ok, _ = pcall(require, "impatient")
--if ok then
--    _.enable_profile()
--end

require("config/core")

nvim_set_var("knobs_default_level", 5)

-- Levels at which knobs are enabled
nvim_set_var(
    "knobs_levels",
    {
        ale = 3,
        apathy = 6,
        airline = 9,
        autopairs = 3,
        autosave = 3,
        barbar = 6,
        colorizer = 4,
        conflict_marker = 7,
        commentary = 4,
        cmp = 4,
        dap = 9,
        defaults = 1,
        devicons = 4,
        dispatch = 4,
        editorconfig = 4,
        endwise = 7,
        eunuch = 3,
        fugitive = 3,
        friendly_snippets = 5,
        fzf = 1,
        gitgutter = 6,
        gitsigns = 4,
        gruvbox = 4,
        gruvbox8 = 1,
        glow = 3,
        goyo = 9,
        gv = 5,
        indent_blankline = 4,
        indentline = 4,
        nerdtree = 9,
        lens = 8,
        lightbulb = 4,
        lsp = 4,
        lsp_colors = 3,
        lspconfig = 4,
        lspkind = 4,
        lualine = 3,
        markdown_syntax_table = 3,
        markdown_preview = 3,
        minimap = 9,
        modes = 3,
        neoscroll = 3,
        nnn = 9,
        nvim_tree = 3,
        peekaboo = 9,
        polyglot = 9,
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
        which_key = 3,
        window_cleaner = 3,
        writegood = 6,
        vimspector = 9,
        vsnip = 6,
        zen_mode = 6,
        zephyr = 9
    }
)

-- Feature toggles triggered by each layer
nvim_set_var(
    "knobs_layers_map",
    {
        debug = {
            debug = 1
        },
        mobile = {
            compactcmd = 1,
            light = 1,
            markdown_flow = 1,
            markdown_conceal_full = 1,
            markdown_syntax_list = 1
        }
    }
)

g.indentLine_enabled = 1
g.indent_blankline_char = "▏"

g.indent_blankline_filetype_exclude = {"help", "startify", "terminal"}
g.indent_blankline_buftype_exclude = {"terminal"}

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false

return require("packer").startup {
    function(_use)
        o["runtimepath"] = o["runtimepath"] .. ",~/.vim"

        --vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")
        --use {"lewis6991/impatient.nvim", rocks = "mpack"}

        local ok, knobs = pcall(require, "knobs")
        use = ok and knobs.use(_use) or _use

        use "wbthomason/packer.nvim"
        use "ianhomer/knobs.vim"

        -- LSP, autocomplete and code guidance
        use {
            "neovim/nvim-lspconfig",
            config = [[require'config.lspconfig']]
        }
        use {
            "ray-x/lsp_signature.nvim",
            commit = "600111e6249bcc948e2b811ef09adf4ea84ebfc1"
        }
        use {
            "weilbith/nvim-code-action-menu",
            cmd = "CodeActionMenu",
            commit = "d3d059082eff3eb081167f8a232b1bde54bb2bdb"
        }
        _use {
            "onsails/lspkind-nvim",
            config = [[require("lspkind").init()]],
            commit = "1557ce5b3b8e497c1cb1d0b9d967a873136b0c23"
        }

        _use {
            "hrsh7th/nvim-cmp",
            requires = "hrsh7th/cmp-buffer",
            config = [[require'config.cmp']],
            commit = "1c7f73aa4ad2ca1d25ea57ba5ab4e43df85d3479"
        }

        use {
            knob = "cmp",
            "hrsh7th/cmp-nvim-lsp",
            after = "nvim-cmp",
            commit = "134117299ff9e34adde30a735cd8ca9cf8f3db81"
        }

        use {
            "hrsh7th/cmp-nvim-lua",
            after = "cmp-nvim-lsp",
            commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21"
        }

        use {
            "hrsh7th/cmp-path",
            after = "cmp-nvim-lsp",
            commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21"
        }

        use {
            knob = "vsnip",
            "hrsh7th/cmp-vsnip",
            after = "cmp-nvim-lsp",
            commit = "0abfa1860f5e095a07c477da940cfcb0d273b700"
        }

        use {
            knob = "vsnip",
            "rafamadriz/friendly-snippets",
            event = "InsertCharPre",
            commit = "05bfa7681b8f11b664fab657001c2efb6f3ec85e"
        }

        use {
            "hrsh7th/vim-vsnip",
            event = "InsertEnter",
            requires = {
                {"hrsh7th/vim-vsnip-integ", cond = "vim.g['knob_vsnip']"}
            },
            commit = "60ee20318550f4a5b6f7a5a8b827540c2c386898"
        }

        use {
            "kosayoda/nvim-lightbulb",
            config = [[require'config.lightbulb']],
            commit = "cd5267d2d708e908dbd668c7de74e1325eb1e1da"
        }

        use {
            cmd = "Vista",
            "liuchengxu/vista.vim",
            commit = "a0469c645dcbe4033b857da27d35491f39e2f776"
        }

        -- Lua
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.trouble']],
            commit = "756f09de113a775ab16ba6d26c090616b40a999d"
        }

        use {
            "majutsushi/tagbar",
            cmd = "TagbarToggle",
            config = [[require'config.tagbar']],
            commit = "b6669c7c9de542c53f2d19a806abb7610e9ef813"
        }

        use {
            "folke/lsp-colors.nvim",
            commit = "517fe3ab6b63f9907b093bc9443ef06b56f804f3"
        }

        use {
            "dense-analysis/ale",
            ft = {"sh", "javascript", "markdown", "lua", "python", "typescript", "vim"},
            cmd = {"ALEFix"},
            commit = "31dc6a61a07839ea906f6f0b80be713fb8cad1c7"
        }
        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = [[require'config.treesitter']],
            run = ":TSUpdate"
        }
        use {
            knob = "dap",
            "nvim-telescope/telescope-dap.nvim",
            commit = "b4134fff5cbaf3b876e6011212ed60646e56f060"
        }
        use {
            "mfussenegger/nvim-dap",
            config = [[require'config.dap']],
            commit = "1a87456d280e8e308df7983650a5ea2b5a6bfb63"
        }
        use {
            knob = "dap",
            "rcarriga/nvim-dap-ui",
            requires = "mfussenegger/nvim-dap",
            config = [[require'config.dapui']],
            commit = "649e0fee4f0b8dc6305dd29065c7623c3dc6a032"
        }
        use {
            "puremourning/vimspector",
            config = [[require'config.vimspector']],
            commit = "14fc10923fb29da1947767e746aa2fbd8147a9ab"
        }

        -- Navigation

        use {"mhinz/vim-startify", commit = "81e36c352a8deea54df5ec1e2f4348685569bed2"}
        use {
            "junegunn/fzf.vim",
            cmd = {"Ag", "Buffers", "Commits", "Files", "History"},
            fn = {"fzf#vim#ag"},
            requires = {{"junegunn/fzf", opt = true, fn = {"fzf#shellescape"}}},
            commit = "d6aa21476b2854694e6aa7b0941b8992a906c5ec"
        }
        use {
            "nvim-lua/plenary.nvim",
            commit = "1c31adb35fcebe921f65e5c6ff6d5481fa5fa5ac"
        }
        use {
            knob = "telescope",
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            commit = "59e38e1661ffdd586cb7fc22ca0b5a05c7caf988"
        }
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim", cond = "vim.g['knob_telescope']"},
                {"nvim-lua/plenary.nvim", cond = "vim.g['knob_telescope']"},
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    cond = "vim.g['knob_telescope']"
                }
            },
            config = [[require'config.telescope']],
            commit = "9ac89ebf6755e9a3f4bae86625ec76106526e57b"
        }
        use {
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.nvimtree']],
            cmd = {"NvimTreeFindFile", "NvimTreeOpen", "NvimTreeToggle"},
            commit = "5d8453dfbd34ab00cb3e8ce39660f9a54cdd35f3"
        }
        use {
            "ryanoasis/vim-devicons",
            commit = "d16475cbd7d50664e3d9261951cd4415967c5c41"
        }
        use {"wfxr/minimap.vim", cmd = {"Minimap"}, commit = "f699b8296c878a5d669f3a13a9d6f916f6276bef"}
        use {
            "folke/which-key.nvim",
            event = "BufWinEnter",
            config = [[require'config.which_key']],
            commit = "d3032b6d3e0adb667975170f626cb693bfc66baa"
        }
        use {
            "phaazon/hop.nvim",
            config = [[require'config.hop']],
            commit = "c9874239338767b3545f1b8a094bb5b9b2df9e56"
        }
        use {
            "christoomey/vim-tmux-navigator",
            commit = "9ca5bfe5bd274051b5dd796cc150348afc993b80"
        }

        -- Note that hoob3rt has stagnated and shadmansaleh continues ...
        use {
            "nvim-lualine/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true},
            config = [[require'config.lualine']]
        }
        use {
            "romgrk/barbar.nvim",
            requires = {"kyazdani42/nvim-web-devicons"},
            config = [[require'config.barbar']],
            commit = "6e638309efcad2f308eb9c5eaccf6f62b794bbab"
        }

        -- Style
        use {
            "morhetz/gruvbox",
            commit = "bf2885a95efdad7bd5e4794dd0213917770d79b7"
        }
        use {
            "lifepillar/gruvbox8",
            commit = "1e205910e67003ff9efb77e7730f1e49d8aae29c"
        }
        use {
            "norcalli/nvim-colorizer.lua",
            config = [[require'config.colorizer']],
            cmd = "BufRead",
            commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6"
        }
        use {
            "karb94/neoscroll.nvim",
            config = [[require'config.neoscroll']],
            commit = "cd4278795ed8ee120a97078b03aa6436802126d9"
        }

        -- Git
        use {"tpope/vim-fugitive", cmd = {"G", "Git", "Gstatus", "Gblame", "Ggrep", "Gpush", "Gpull"}}
        use {"tpope/vim-rhubarb", cmd = {"GBrowse"}}
        use {
            "airblade/vim-gitgutter",
            commit = "256702dd1432894b3607d3de6cd660863b331818"
        }
        use {
            "tpope/vim-dispatch"
        }
        use {
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = [[require'config.gitsigns']],
            commit = "ba1932ab3ed09de0706215b6e8eeb75566da21ac"
        }
        use {
            "junegunn/gv.vim",
            cmd = {"GV"},
            commit = "386d770e916dd680d1d622e715b9eb3a77f21bd1"
        }
        -- Editing
        use {
            "windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = [[require'config.autopairs']],
            commit = "1f18e79ee9b30fec25c3f32b1ed22c3290f07bb2"
        }
        use {
            "tpope/vim-surround"
        }
        use "tpope/vim-commentary"
        use {
            "tpope/vim-unimpaired"
        }
        use "tpope/vim-repeat"
        use {"godlygeek/tabular", cmd = {"Tabularize"}}

        use {
            "editorconfig/editorconfig-vim",
            commit = "3078cd10b28904e57d878c0d0dab42aa0a9fdc89"
        }
        use {
            "chrisbra/unicode.vim",
            commit = "664d7b2e5cedf36ea3a85ad7e8e28e43c16f025b"
        }

        vim.api.nvim_set_keymap("n", "<space>i", "<cmd>:ZenMode<CR>", {})
        use {
            "folke/zen-mode.nvim",
            cmd = {"ZenMode"},
            config = [[require'config.zen_mode']]
        }

        use {
            "junegunn/goyo.vim",
            commit = "a865dec7ca7616dbbd69315ad1417b84d0c411f8"
        }

        use {
            "ellisonleao/glow.nvim",
            cmd = {"Glow"},
            commit = "708d3f3aca0f4e6bc9a6b9188bc7b37a828b8fa7"
        }
        use {
            "iamcco/markdown-preview.nvim",
            -- cmd = {"MarkdownPreview"},
            run = "cd app && yarn install",
            commit = "e5bfe9b89dc9c2fbd24ed0f0596c85fd0568b143"
        }
        use {
            "lukas-reineke/indent-blankline.nvim",
            commit = "9f663d31d4ee0672f24cd5b26ca3863665048a25"
        }
        use {
            "junegunn/vim-peekaboo",
            commit = "cc4469c204099c73dd7534531fa8ba271f704831"
        }

        -- Misc

        use {
            "akinsho/toggleterm.nvim",
            cmd = {"ToggleTerm", "TermExec"},
            config = [[require'config.toggleterm']],
            commit = "ff168c8218b963cc7fc9d80b684d840488839bb5"
        }
        use {
            "tpope/vim-eunuch",
            commit = "7a48f9ff0ef5f21447b2354ee52dc18b5567e05c"
        }

        -- Diagnostics
        --
        -- use {'dstein64/vim-startuptime'}
        use {
            "tweekmonster/startuptime.vim",
            commit = "dfa57f522d6f61793fe5fea65bca7484751b8ca2"
        }
    end,
    config = {
        profile = {
            enable = true,
            compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua"
        }
    }
}
