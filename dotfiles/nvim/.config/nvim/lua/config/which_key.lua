local wk = require("which-key")
local knobs = require("knobs")

wk.setup {}

local map = {}
if knobs.has("telescope") then
    map["fb"] = {"<cmd>Telescope git_bcommits<cr>", "Buffer commits"}
    map["fc"] = {"<cmd>Telescope commands<cr>", "Recent commands"}
    map["fd"] = {"<cmd>Telescope lsp_document_symbols<cr>", "LSP document symbols"}
    map["ff"] = {"<cmd>Telescope find_files hidden=true<cr>", "Find File"}
    map["ft"] = {"<cmd>Telescope<cr>", "Telescope"}
    map["fS"] = {"<cmd>Telescope live_grep hidden=true<cr>", "Search"}
    map["fh"] = {"<cmd>Telescope oldfiles<cr>", "File History"}
    map["fH"] = {"<cmd>Telescope help_tags<cr>", "Help"}
    map["ft"] = {"<cmd>Telescope tags<cr>", "Tags"}
    map["<space>"] = {"<cmd>Telescope buffers<cr>", "Buffers"}
end

if knobs.has("toggleterm") then
    map["a"] = {"<cmd>ToggleTerm<cr>", "Terminal"}
end

if knobs.has("nvim_tree") then
    map["n"] = {"<cmd>NvimTreeOpen<cr>" .. "<cmd>NvimTreeFindFile<cr>", "Files"}
end

map["h"] = {"<cmd>lua require'hop'.hint_words()<cr>", "Hop"}

wk.register(map, {prefix = "<leader>"})
