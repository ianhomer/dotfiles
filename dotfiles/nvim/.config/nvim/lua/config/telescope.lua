local actions = require("telescope.actions")
-- local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

telescope.setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
            "--glob",
            "!**/.git/**",
            "--hidden"
        },
        mappings = {
            i = {
                ["<esc>"] = actions.close
            }
        },
        --    i = {["<c-t>"] = trouble.open_with_trouble},
        --    n = {["<c-t>"] = trouble.open_with_trouble}
        --},
        path_display = {"shorten"},
        layout_config = {
            horizontal = {
                height = 0.95,
                width = 0.95
            }
        }
    }
}
telescope.load_extension("fzf")

local opt = {noremap = true, silent = true}
