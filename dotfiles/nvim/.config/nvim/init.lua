local cmd = vim.cmd
local o = vim.o
local nvim_set_var = vim.api.nvim_set_var

-- Default values for knobs
nvim_set_var(
    "knobs_defaults",
    {
        markdown_syntax_table = 1
    }
)

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
        },
        nvim_0_5 = {
            lsp = 1
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
        useif {
            "tjdevries/gruvbuddy.nvim",
            requires = {"tjdevries/colorbuddy.vim"}
            -- config = function() require('colorbuddy').colorscheme('gruvbuddy') end
        }

        use {"kosayoda/nvim-lightbulb"}
        use {"onsails/lspkind-nvim"}

        use {"junegunn/fzf"}
        use {"junegunn/fzf.vim"}
        use {"tpope/vim-fugitive", cmd = {"Git", "Gstatus", "Gblame", "Gpush", "Gpull"}}

        use {"tpope/vim-rhubarb"}
        useif {"airblade/vim-gitgutter"}
        useif {"tpope/vim-dispatch"}
        use {"preservim/nerdtree", cmd = {"NERDTreeFind", "NERDTreeToggle"}}
        useif {"mhinz/vim-startify"}

        use {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        }

        cmd "let g:gutentags_cache_dir = expand('~/.cache/tags')"

        use {"ludovicchabant/vim-gutentags"}
        use {"godlygeek/tabular", cmd = {"Tabularize"}}

        use {"junegunn/goyo.vim"}
        use {"tpope/vim-surround"}

        use "neovim/nvim-lspconfig"
        useif {
            "hrsh7th/nvim-compe",
            config = function()
                require("compe-init").setup()
            end
        }

        use {"iamcco/markdown-preview.nvim", run = "cd app && yarn install"}

        use "christoomey/vim-tmux-navigator"

        -- use {'dstein64/vim-startuptime'}
        use {"tweekmonster/startuptime.vim"}

        useif {"ryanoasis/vim-devicons"}
        use {"wfxr/minimap.vim", cmd = {"Minimap"}}

        use {"dense-analysis/ale", cmd = {"ALEFix"}}
        use {"liuchengxu/vim-which-key"}

        require("lsp")
        require("lspkind").init()
        require("lualine").setup {
            options = {
                sources = {"ale"},
                theme = "gruvbox"
            },
            sections = {
                lualine_c = {
                    {"filename"},
                    {"diagnostics", sources = {"ale"}, color_error = "#ffffff"}
                }
            }
        }
    end
)
