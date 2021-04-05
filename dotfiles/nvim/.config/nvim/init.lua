local cmd = vim.cmd
local o = vim.o
local nvim_set_var = vim.api.nvim_set_var

-- Levels at which knobs are enabled
nvim_set_var(
    "knobs_levels",
    {
        ale = 4,
        apathy = 5,
        airline = 5,
        autosave = 4,
        chadtree = 7,
        colorbuddy = 6,
        conflict_marker = 7,
        compe = 5,
        devicons = 5,
        dispatch = 5,
        endwise = 5,
        eunuch = 5,
        fugitive = 4,
        fzf = 4,
        gitgutter = 5,
        gruvbox = 5,
        gruvbox8 = 4,
        gruvbuddy = 6,
        goyo = 4,
        gutentags = 5,
        nerdtree = 5,
        lens = 8,
        lightbulb = 5,
        lsp = 1,
        markdown_syntax_table = 1,
        minimap = 5,
        modes = 1,
        nnn = 6,
        polyglot = 5,
        spelling = 4,
        startify = 5,
        startuptime = 5,
        surround = 4,
        tabcomplete = 4,
        tabular = 4,
        thingity = 4,
        unimpaired = 4,
        update_spelling = 6,
        which_key = 5,
        window_cleaner = 4,
        writegood = 8,
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

        cmd "call knobs#Init()"

        use "wbthomason/packer.nvim"

        use {"rakr/vim-one"}
        useif {"morhetz/gruvbox"}
        useif {"lifepillar/gruvbox8"}
        useif {"glepnir/zephyr-nvim"}

        useif {"mhinz/vim-startify"}
        use {
            "junegunn/fzf.vim",
            cmd = {"Ag", "Buffers", "Files"},
            requires = {"junegunn/fzf"}
        }
        use {"preservim/nerdtree", cmd = {"NERDTreeFind", "NERDTreeToggle"}}
        useif {"ryanoasis/vim-devicons"}
        use {"wfxr/minimap.vim", cmd = {"Minimap"}}
        use {"liuchengxu/vim-which-key"}
        use "christoomey/vim-tmux-navigator"

        use {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        }

        use {"tpope/vim-fugitive", cmd = {"Git", "Gstatus", "Gblame", "Gpush", "Gpull"}}
        use {"tpope/vim-rhubarb", cmd = {"GBrowse"}}
        useif {"airblade/vim-gitgutter"}
        useif {"tpope/vim-dispatch"}

        use {"tpope/vim-surround"}
        use {"godlygeek/tabular", cmd = {"Tabularize"}}

        use {"junegunn/goyo.vim"}
        use {
            "iamcco/markdown-preview.nvim",
            -- cmd = {"MarkdownPreview"},
            run = "cd app && yarn install"
        }

        use "neovim/nvim-lspconfig"
        useif {
            "hrsh7th/nvim-compe",
            config = [[require('config.compe')]]
        }
        use {
            "kosayoda/nvim-lightbulb",
            config = [[require('config.lightbulb')]]
        }
        use {"onsails/lspkind-nvim"}

        cmd "let g:gutentags_cache_dir = expand('~/.cache/tags')"
        use {"ludovicchabant/vim-gutentags"}

        use {
            "dense-analysis/ale",
            ft = {"sh", "javascript", "markdown", "lua", "python", "typescript", "vim"},
            cmd = {"ALEFix"}
        }

        -- use {'dstein64/vim-startuptime'}
        use {"tweekmonster/startuptime.vim"}

        require("config.lsp")
        require("lspkind").init()
        require("lualine").setup {
            options = {
                sources = {"ale"},
                theme = "gruvbox"
            },
            sections = {
                lualine_c = {
                    {"filename"},
                    {
                        "diagnostics",
                        sources = {"ale", "nvim_lsp"},
                        color_error = "#ffffff"
                    }
                }
            }
        }
    end
)
