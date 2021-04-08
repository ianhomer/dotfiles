local cmd = vim.cmd
local o = vim.o
local nvim_set_var = vim.api.nvim_set_var

-- Levels at which knobs are enabled
nvim_set_var(
    "knobs_levels",
    {
        ale = 9,
        apathy = 5,
        airline = 5,
        autosave = 4,
        chadtree = 7,
        conflict_marker = 7,
        compe = 5,
        devicons = 5,
        dispatch = 5,
        endwise = 5,
        eunuch = 5,
        fugitive = 3,
        fzf = 3,
        gitgutter = 5,
        gruvbox = 5,
        gruvbox8 = 1,
        goyo = 3,
        gutentags = 5,
        nerdtree = 5,
        lens = 8,
        lightbulb = 5,
        lsp = 1,
        lspconfig = 5,
        lspkind = 5,
        lualine = 3,
        markdown_syntax_table = 1,
        minimap = 5,
        modes = 1,
        nnn = 6,
        polyglot = 5,
        spelling = 4,
        startify = 5,
        startuptime = 5,
        surround = 3,
        tabcomplete = 3,
        tabular = 3,
        thingity = 3,
        unimpaired = 4,
        update_spelling = 6,
        which_key = 5,
        window_cleaner = 3,
        writegood = 5,
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

        cmd "call knobs#Init()"
        local knobs = require("knobs")
        local useif = knobs.useif(use)

        use "wbthomason/packer.nvim"

        use "rakr/vim-one"
        use "morhetz/gruvbox"
        useif {"lifepillar/gruvbox8"}
        useif {"glepnir/zephyr-nvim"}

        useif {"mhinz/vim-startify"}
        use {
            "junegunn/fzf.vim",
            cmd = {"Ag", "Buffers", "Files"},
            fn = {"fzf#vim#ag"},
            requires = {"junegunn/fzf"}
        }
        use {"preservim/nerdtree", cmd = {"NERDTreeFind", "NERDTreeToggle"}}
        useif {"ryanoasis/vim-devicons"}
        use {"wfxr/minimap.vim", cmd = {"Minimap"}}
        use "liuchengxu/vim-which-key"
        use "christoomey/vim-tmux-navigator"

        useif {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true},
            config = [[require'config.lualine']]
        }

        use {"tpope/vim-fugitive", cmd = {"Git", "Gstatus", "Gblame", "Gpush", "Gpull"}}
        use {"tpope/vim-rhubarb", cmd = {"GBrowse"}}
        useif {"airblade/vim-gitgutter"}
        useif {"tpope/vim-dispatch"}
        -- use {
          -- 'lewis6991/gitsigns.nvim',
          -- config = [[require'config.gitsigns']],
          -- requires = {
            -- 'nvim-lua/plenary.nvim'
          -- }
        -- }

        use "tpope/vim-surround"
        use {"godlygeek/tabular", cmd = {"Tabularize"}}

        use "junegunn/goyo.vim"
        use {
            "iamcco/markdown-preview.nvim",
            -- cmd = {"MarkdownPreview"},
            run = "cd app && yarn install"
        }

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

        use "junegunn/vim-peekaboo"

        cmd "let g:gutentags_cache_dir = expand('~/.cache/tags')"
        use {"ludovicchabant/vim-gutentags"}

        use {
            "dense-analysis/ale",
            ft = {"sh", "javascript", "markdown", "lua", "python", "typescript", "vim"},
            cmd = {"ALEFix"}
        }

        -- use {'dstein64/vim-startuptime'}
        use "tweekmonster/startuptime.vim"
    end
)
