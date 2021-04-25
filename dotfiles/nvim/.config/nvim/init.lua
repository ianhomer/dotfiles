local cmd = vim.cmd
local o = vim.o
local nvim_set_var = vim.api.nvim_set_var

-- Levels at which knobs are enabled
nvim_set_var(
    "knobs_levels",
    {
        ale = 5,
        apathy = 6,
        airline = 9,
        auto_pairs = 6,
        autosave = 4,
        colorbuddy = 7,
        colorizer = 5,
        conflict_marker = 7,
        compe = 5,
        devicons = 5,
        dispatch = 5,
        endwise = 7,
        eunuch = 7,
        fugitive = 3,
        friendly_snippets = 5,
        fzf = 1,
        gitgutter = 6,
        gruvbox = 5,
        gruvbuddy = 7,
        gruvbox8 = 1,
        goyo = 3,
        gutentags = 5,
        nerdtree = 5,
        lens = 8,
        lightbulb = 5,
        lsp = 3,
        lspconfig = 5,
        lspkind = 4,
        lualine = 4,
        markdown_syntax_table = 3,
        markdown_preview = 3,
        material = 9,
        minimap = 4,
        modes = 3,
        nnn = 7,
        peekaboo = 3,
        polyglot = 9,
        rhubarb = 7,
        spelling = 4,
        startify = 5,
        startuptime = 1,
        surround = 3,
        tabcomplete = 9,
        tabular = 3,
        telescope = 5,
        thingity = 3,
        treesitter = 5,
        unimpaired = 4,
        update_spelling = 7,
        which_key = 4,
        window_cleaner = 3,
        writegood = 3,
        tmux_navigator = 3,
        vsnip = 5,
        zephyr = 9
    }
)

-- Feature toggles triggered by each layer
nvim_set_var(
    "knobs_layers_map",
    {
        mobile = {
            compactcmd = 1,
            light = 1,
            markdown_flow = 1,
            markdown_conceal_full = 1,
            markdown_syntax_list = 1
        },
        notes = {
            compactcmd = 1,
            light = 1,
            markdown_conceal_partial = 1
        }
    }
)

cmd "packadd packer.nvim" -- load the package manager

return require("packer").startup(
    function(use)
        o["runtimepath"] = o["runtimepath"] .. ",~/.vim"

        local knobs = require("knobs")
        local useif = knobs.useif(use)

        use "wbthomason/packer.nvim"

        -- LSP, autocomplete and code guidance
        useif {
            "neovim/nvim-lspconfig",
            config = [[require'config.lspconfig']]
        }
        useif {
            "hrsh7th/nvim-compe",
            config = [[require'config.compe']]
        }
        useif {
            "kosayoda/nvim-lightbulb",
            config = [[require'config.lightbulb']]
        }
        useif {"onsails/lspkind-nvim", config = [[require("lspkind").init()]]}
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
            config = [[require'config.treesitter']]
        }
        useif "rafamadriz/friendly-snippets"
        useif "hrsh7th/vim-vsnip"

        -- Navigation

        useif {"mhinz/vim-startify"}
        use {
            "junegunn/fzf.vim",
            cmd = {"Ag", "Buffers", "Commits", "Files", "History"},
            fn = {"fzf#vim#ag"},
            requires = {{"junegunn/fzf", opt = true, fn = {"fzf#shellescape"}}}
        }
        use { "nvim-lua/plenary.nvim" }
        useif {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim", cond = "vim.g['knob_telescope']"},
                {"nvim-lua/plenary.nvim", cond = "vim.g['knob_telescope']"}
            },
            config = [[require'config.telescope']]
        }
        use {"preservim/nerdtree", cmd = {"NERDTreeFind", "NERDTreeToggle"}}
        useif {"ryanoasis/vim-devicons"}
        use {"wfxr/minimap.vim", cmd = {"Minimap"}}
        useif {
            "liuchengxu/vim-which-key",
            config = [[require'config.which_key']]
        }
        useif "christoomey/vim-tmux-navigator"

        useif {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true},
            config = [[require'config.lualine']]
        }

        -- Style
        use {"rakr/vim-one", disable = true}
        use {"tjdevries/gruvbuddy.nvim", disable = true}
        useif {"tjdevries/colorbuddy.nvim", config = [[require'config.colorbuddy']], disable = true}
        use {"marko-cerovac/material.nvim", disable = true}

        useif "morhetz/gruvbox"
        useif {"lifepillar/gruvbox8"}
        use {"glepnir/zephyr-nvim", disable = true}
        useif {"norcalli/nvim-colorizer.lua", config = [[require'config.colorizer']]}

        -- Git
        use {"tpope/vim-fugitive", cmd = {"Git", "Gstatus", "Gblame", "Gpush", "Gpull"}}
        useif {"tpope/vim-rhubarb", cmd = {"GBrowse"}}
        useif {"airblade/vim-gitgutter"}
        useif {"tpope/vim-dispatch"}

        -- Editing
        useif "tpope/vim-surround"
        use {"godlygeek/tabular", cmd = {"Tabularize"}}

        useif "junegunn/goyo.vim"
        useif {
            "iamcco/markdown-preview.nvim",
            -- cmd = {"MarkdownPreview"},
            run = "cd app && yarn install"
        }

        useif {"junegunn/vim-peekaboo"}

        -- Diagnostics
        --
        -- use {'dstein64/vim-startuptime'}
        useif "tweekmonster/startuptime.vim"
    end
)
