local wk = require("which-key")
local knobs = require("knobs")

wk.setup {}

local map = {}
if vim.g.knob_telescope then
    -- Common Searches
    map["f"] = {"<cmd>Telescope find_files hidden=true<cr>", "Find File"}
    map["s"] = {"<cmd>Telescope live_grep<cr>", "Search"}
    map["<space>"] = {"<cmd>Telescope buffers<cr>", "Buffers"}

    -- Alternatives
    map["tS"] = {"<cmd>Telescope live_grep hidden=true<cr>", "Search"}
    map["tg"] = {"<cmd>Telescope grep_string<cr>", "Grep String"}

    -- File
    map["tF"] = {"<cmd>Telescope file_browser<cr>", "File Browser"}

    -- Pickers
    map["tt"] = {"<cmd>Telescope<cr>", "Telescope"}
    map["th"] = {"<cmd>Telescope oldfiles<cr>", "File History"}
    map["tH"] = {"<cmd>Telescope help_tags<cr>", "Help"}
    map["tt"] = {"<cmd>Telescope tags<cr>", "Tags"}
    map["tl"] = {"<cmd>Telescope highlights<cr>", "Telescope"}
    map["tc"] = {"<cmd>Telescope command_history<cr>", "Recent Commands"}
    map["tC"] = {"<cmd>Telescope commands<cr>", "Available Commands"}
    map["t3"] = {"<cmd>Telescope search_history<cr>", "Search History"}
    map["tq"] = {"<cmd>Telescope quickfix<cr>", "Quick Fix"}
    map["tl"] = {"<cmd>Telescope loclist<cr>", "Location List"}
    map["tj"] = {"<cmd>Telescope jumplist<cr>", "Jump List"}
    map["t4"] = {"<cmd>Telescope spell_suggest", "Spell Suggest"}

    -- Git
    map["tb"] = {"<cmd>Telescope git_bcommits<cr>", "Buffer Commits"}
    map["t1"] = {"<cmd>Telescope git_stash<cr>", "Git Stash"}
    map["t2"] = {"<cmd>Telescope git_branches<cr>", "Git Branches"}


    -- LSP
    map["td"] = {"<cmd>Telescope lsp_document_symbols<cr>", "LSP document symbols"}
end

if vim.g.knob_toggleterm then
    map["a"] = {"<cmd>ToggleTerm<cr>", "Terminal"}
end

if vim.g.knob_nvim_tree then
    map["n"] = {"<cmd>NvimTreeOpen<cr>" .. "<cmd>NvimTreeFindFile<cr>", "Files"}
end

map["h"] = {"<cmd>lua require'hop'.hint_words()<cr>", "Hop"}

wk.register(map, {prefix = "<leader>"})
