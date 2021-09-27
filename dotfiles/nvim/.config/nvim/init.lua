local cmd = vim.cmd
local g = vim.g
local o = vim.o
local nvim_set_var = vim.api.nvim_set_var

vim.opt.shell = "/bin/bash"

require("config/core")

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
        colorizer = 5,
        conflict_marker = 7,
        commentary = 5,
        cmp = 5,
        defaults = 1,
        devicons = 5,
        dispatch = 5,
        editorconfig = 5,
        endwise = 7,
        eunuch = 3,
        fugitive = 3,
        friendly_snippets = 5,
        fzf = 1,
        gitgutter = 6,
        gitsigns = 5,
        gruvbox = 5,
        gruvbox8 = 1,
        glow = 3,
        goyo = 9,
        gutentags = 6,
        gv = 5,
        indent_blankline = 5,
        indentline = 5,
        nerdtree = 9,
        lens = 8,
        lightbulb = 5,
        lsp = 5,
        lsp_colors = 3,
        lspconfig = 5,
        lspkind = 5,
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
        startify = 5,
        startuptime = 1,
        surround = 3,
        tabcomplete = 9,
        tabular = 3,
        telescope = 5,
        thingity = 3,
        tmux_navigator = 3,
        toggleterm = 3,
        treesitter = 3,
        trouble = 5,
        twightlight = 9,
        unicode = 4,
        unimpaired = 5,
        update_spelling = 7,
        which_key = 3,
        window_cleaner = 3,
        writegood = 6,
        vsnip = 5,
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

cmd "packadd packer.nvim" -- load the package manager

return require("packer").startup {
    function(use)
        o["runtimepath"] = o["runtimepath"] .. ",~/.vim"

        -- vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")
        -- use {"lewis6991/impatient.nvim", rocks = "mpack"}
        -- require('impatient').enable_profile()

        local knobs = require("knobs")
        local useif = knobs.use(use)

        use {
            "wbthomason/packer.nvim",
            event = "VimEnter"
        }
        -- LSP, autocomplete and code guidance
        use {
            "neovim/nvim-lspconfig",
            config = [[require'config.lspconfig']]
        }
        use {"onsails/lspkind-nvim", config = [[require("lspkind").init()]]}
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/cmp-buffer"
            },
            config = [[require'config.cmp']]
        }

        use {
            "hrsh7th/cmp-nvim-lsp",
            after = "nvim-cmp"
        }

        use {
            "hrsh7th/cmp-nvim-lua",
            after = "cmp-nvim-lsp"
        }

        use {
            "hrsh7th/cmp-path",
            after = "cmp-nvim-lsp"
        }

        useif {
            knob = "vsnip",
            "hrsh7th/cmp-vsnip",
            after = "cmp-nvim-lsp"
        }

        use {
            "rafamadriz/friendly-snippets",
            event = "InsertCharPre"
        }

        useif {
            "hrsh7th/vim-vsnip",
            event = "InsertEnter",
            requires = {
                {"hrsh7th/vim-vsnip-integ", cond = "vim.g['knob_vsnip']"}
            }
        }

        useif {
            "kosayoda/nvim-lightbulb",
            config = [[require'config.lightbulb']]
        }

        -- Lua
        useif {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.trouble']]
        }

        useif {
          "folke/lsp-colors.nvim"
        }

        cmd [[let g:gutentags_cache_dir = expand('~/.cache/tags')]]
        useif {
            "ludovicchabant/vim-gutentags"
        }
        use {
            "dense-analysis/ale",
            ft = {"sh", "javascript", "markdown", "lua", "python", "typescript", "vim"},
            cmd = {"ALEFix"}
        }
        useif {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = [[require'config.treesitter']]
        }

        -- Navigation

        useif {"mhinz/vim-startify"}
        use {
            "junegunn/fzf.vim",
            cmd = {"Ag", "Buffers", "Commits", "Files", "History"},
            fn = {"fzf#vim#ag"},
            requires = {{"junegunn/fzf", opt = true, fn = {"fzf#shellescape"}}}
        }
        use {"nvim-lua/plenary.nvim"}
        use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        useif {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim", cond = "vim.g['knob_telescope']"},
                {"nvim-lua/plenary.nvim", cond = "vim.g['knob_telescope']"},
                {"nvim-telescope/telescope-fzf-native.nvim"}
            },
            config = [[require'config.telescope']]
        }
        use {
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = [[require'config.nvimtree']],
            cmd = {"NvimTreeFindFile", "NvimTreeToggle"}
        }
        useif {"ryanoasis/vim-devicons"}
        use {"wfxr/minimap.vim", cmd = {"Minimap"}}
        useif {
            "folke/which-key.nvim",
            event = "BufWinEnter",
            config = [[require'config.which_key']]
        }
        use "christoomey/vim-tmux-navigator"

        -- Note that hoob3rt has stagnated and shadmansaleh continues ...
        useif {
            "shadmansaleh/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true},
            config = [[require'config.lualine']]
        }
        use {
            "romgrk/barbar.nvim",
            requires = {"kyazdani42/nvim-web-devicons"},
            config = [[require'config.barbar']]
        }

        -- Style
        useif "morhetz/gruvbox"
        useif {"lifepillar/gruvbox8"}
        use {"glepnir/zephyr-nvim", disable = true}
        useif {
            "norcalli/nvim-colorizer.lua",
            config = [[require'config.colorizer']]
        }
        useif {
          "karb94/neoscroll.nvim",
          config = [[require'config.neoscroll']]
        }

        -- Git
        use {"tpope/vim-fugitive", cmd = {"G", "Git", "Gstatus", "Gblame", "Ggrep", "Gpush", "Gpull"}}
        use {"tpope/vim-rhubarb", cmd = {"GBrowse"}}
        useif {"airblade/vim-gitgutter"}
        useif {
            "tpope/vim-dispatch",
            defer = 4000
        }
        useif {
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = [[require'config.gitsigns']]
        }
        use { "junegunn/gv.vim", cmd = {"GV"} }

        -- Editing
        useif {
            "windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = [[require'config.autopairs']]
        }
        useif {
            "tpope/vim-surround"
        }
        useif "tpope/vim-commentary"
        useif {
            "tpope/vim-unimpaired",
            defer = 5000
        }
        use "tpope/vim-repeat"
        use {"godlygeek/tabular", cmd = {"Tabularize"}}

        useif "editorconfig/editorconfig-vim"
        useif "chrisbra/unicode.vim"

        vim.api.nvim_set_keymap("n", "<space>i", "<cmd>:ZenMode<CR>", {})
        use {
            "folke/zen-mode.nvim",
            cmd = {"ZenMode"},
            config = [[require'config.zen_mode']]
        }
        useif {
            "folke/twilight.nvim",
            config = [[require("twilight").setup {}]]
        }

        useif "junegunn/goyo.vim"
        useif {
            "ellisonleao/glow.nvim",
            cmd = {"Glow"}
        }
        use {
            "iamcco/markdown-preview.nvim",
            -- cmd = {"MarkdownPreview"},
            run = "cd app && yarn install",
            defer = 1000
        }
        useif {
            "lukas-reineke/indent-blankline.nvim"
        }
        useif {"junegunn/vim-peekaboo"}

        -- Misc

        use {
            "akinsho/toggleterm.nvim",
            cmd = {"ToggleTerm", "TermExec"},
            config = [[require'config.toggleterm']]
        }
        useif "tpope/vim-eunuch"

        -- Diagnostics
        --
        -- use {'dstein64/vim-startuptime'}
        useif "tweekmonster/startuptime.vim"
    end,
    config = {
        profile = {
            enable = true
        }
    }
}
