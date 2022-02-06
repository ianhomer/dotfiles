local whichKey = require("which-key")
local knobs = require("knobs")

whichKey.setup({
    plugins = {
        spelling = {
            enabled = true,
        },
    },
    window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 1, 2, 1, 0 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 30, max = 50 }, -- min and max width of the columns
        spacing = 2, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
})

local map = {}
if vim.g.knob_telescope then
    -- Common Searches
    map["f"] = { "<cmd>Telescope find_files hidden=true<cr>", "Find File" }
    map["s"] = { "<cmd>Telescope live_grep<cr>", "Search" }
    map["S"] = { "<cmd>Fuzzy<cr>", "Fuzzy Search" }
    map["h"] = { "<cmd>Telescope oldfiles<cr>", "File History" }
    map["<space>"] = { "<cmd>Telescope buffers<cr>", "Buffers" }

    -- Alternatives
    map["tS"] = { "<cmd>Telescope live_grep hidden=true<cr>", "Search" }
    map["tg"] = { "<cmd>Telescope grep_string<cr>", "Grep String" }

    -- File
    map["tf"] = { "<cmd>lua require'telescope.builtin'.find_files({find_command={'fd', '-H', '-i', vim.fn.expand('<cword>')}})<cr>", "Find named file" }
    map["tF"] = { "<cmd>Telescope file_browser<cr>", "File Browser" }

    -- Pickers
    map["t3"] = { "<cmd>Telescope search_history<cr>", "Search History" }
    map["t9"] = { "<cmd>Telescope spell_suggest<cr>", "Spell Suggest" }
    map["tC"] = { "<cmd>Telescope commands<cr>", "Available Commands" }
    map["tH"] = { "<cmd>Telescope help_tags<cr>", "Help" }
    map["tT"] = { "<cmd>Telescope tags<cr>", "Tags" }
    map["tc"] = { "<cmd>Telescope command_history<cr>", "Recent Commands" }
    map["th"] = { "<cmd>Telescope highlights<cr>", "Highlights" }
    map["tj"] = { "<cmd>Telescope jumplist<cr>", "Jump List" }
    map["tk"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" }
    map["tl"] = { "<cmd>Telescope loclist<cr>", "Location List" }
    map["tr"] = { "<cmd>Telescope registers<cr>", "Registers" }
    map["tq"] = { "<cmd>Telescope quickfix<cr>", "Quick Fix" }
    map["tt"] = { "<cmd>Telescope<cr>", "Telescope" }

    -- Git
    map["tb"] = { "<cmd>Telescope git_bcommits<cr>", "Buffer Commits" }
    map["t1"] = { "<cmd>Telescope git_commits<cr>", "Git Commits" }
    map["t2"] = { "<cmd>Telescope git_branches<cr>", "Git Branches" }
    map["t3"] = { "<cmd>Telescope git_stash<cr>", "Git Stash" }

    -- LSP
    map["td"] = { "<cmd>Telescope lsp_document_symbols<cr>", "LSP document symbols" }
    map[";"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "LSP Format" }
    map[":"] = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "LSP Range Format" }
end

if vim.g.knob_toggleterm then
    map["a"] = { "<cmd>ToggleTerm<cr>", "Terminal" }
end

if vim.g.knob_nvim_tree then
    map["n"] = { "<cmd>NvimTreeToggle<cr>", "Files" }
end

map["e"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Diagnostics" }
if vim.g.knob_hop then
    map["h"] = { "<cmd>lua require'hop'.hint_words()<cr>", "Hop" }
end

whichKey.register(map, { prefix = "<leader>" })

local cheats = {}
cheats["m"] = { ":let @m=@+<cr>", ":let @m=@+" }
cheats["M"] = { 'viw"mp<cr>', 'viw"mp' }
cheats["a"] = { ":messages<cr>", ":messages" }
cheats["s"] = { ":let @+ = execute('messages')<cr>", ":let @+ = execute('messages')" }

whichKey.register(cheats, { prefix = "," })
