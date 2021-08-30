local wk = require("which-key")

wk.setup {}

wk.register(
    {
        f = {"<cmd>Telescope find_files hidden=true<cr>", "Find File"},
        n = {"<cmd>NvimTreeFindFile<cr>", "Files"},
        S = {"<cmd>Telescope live_grep hidden=true<cr>", "Search" }
    },
    {prefix = "<leader>"}
)
