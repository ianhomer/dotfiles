local wk = require("which-key")
local knobs = require("knobs")

wk.setup {}

local map = {}
if vim.g.knob_telescope then
    map["tb"] = {"<cmd>Telescope git_bcommits<cr>", "Buffer commits"}
    map["tc"] = {"<cmd>Telescope commands<cr>", "Recent commands"}
    map["td"] = {"<cmd>Telescope lsp_document_symbols<cr>", "LSP document symbols"}
    map["f"] = {"<cmd>Telescope find_files hidden=true<cr>", "Find File"}
    map["tt"] = {"<cmd>Telescope<cr>", "Telescope"}
    map["tS"] = {"<cmd>Telescope live_grep hidden=true<cr>", "Search"}
    map["th"] = {"<cmd>Telescope oldfiles<cr>", "File History"}
    map["tH"] = {"<cmd>Telescope help_tags<cr>", "Help"}
    map["tt"] = {"<cmd>Telescope tags<cr>", "Tags"}
    map["tl"] = {"<cmd>Telescope highlights<cr>", "Telescope"}
    map["<space>"] = {"<cmd>Telescope buffers<cr>", "Buffers"}
end

if vim.g.knob_toggleterm then
    map["a"] = {"<cmd>ToggleTerm<cr>", "Terminal"}
end

if vim.g.knob_nvim_tree then
    map["n"] = {"<cmd>NvimTreeOpen<cr>" .. "<cmd>NvimTreeFindFile<cr>", "Files"}
end

map["h"] = {"<cmd>lua require'hop'.hint_words()<cr>", "Hop"}

wk.register(map, {prefix = "<leader>"})
