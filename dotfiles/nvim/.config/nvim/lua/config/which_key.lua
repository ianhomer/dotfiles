local whichKey = require("which-key")

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

local findNamedFile = {
    "<cmd>lua require'telescope.builtin'.find_files({find_command={'fd', '-H', '-i', vim.fn.expand('<cword>')}})<cr>",
    "Find named file",
}

if vim.g.knob_telescope then
    -- Common Searches
    map["f"] = { "<cmd>Telescope find_files hidden=true<cr>", "Find File" }
    map["s"] = { "<cmd>Telescope live_grep<cr>", "Search" }
    map["S"] = { "<cmd>Fuzzy<cr>", "Fuzzy Search" }
    map["h"] = { "<cmd>Telescope oldfiles<cr>", "File History" }
    map["H"] = { "<cmd>Telescope frecency<cr>", "Frequent" }
    map["<space>"] = { "<cmd>Telescope buffers<cr>", "Buffers" }

    -- Alternatives
    map["tS"] = { "<cmd>Telescope live_grep hidden=true<cr>", "Search" }
    map["tg"] = { "<cmd>Telescope grep_string<cr>", "Grep String" }

    -- File
    map["tf"] = findNamedFile
    map["tF"] = { "<cmd>Telescope file_browser<cr>", "File Browser" }

    -- Pickers
    map["t4"] = { "<cmd>Telescope search_history<cr>", "Search History" }
    map["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search Buffer" }
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
    map["t2"] = { "<cmd>Telescope: git_branches<cr>", "Git Branches" }
    map["t3"] = { "<cmd>Telescope git_stash<cr>", "Git Stash" }

    -- LSP
    map["td"] = { "<cmd>Telescope lsp_document_symbols<cr>", "LSP document symbols" }
    map[";"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "LSP Format" }
    map[":"] = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "LSP Range Format" }

    -- Modes
    map["7"] = { "<cmd>TroubleToggle<cr>", "Trouble"}
    map["8"] = { "<cmd>call my#ToggleGitBlame()<cr>", "Blame"}
    map["9"] = { "<cmd>set wrap! | set wrap?<cr>", "Wrap"}
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
cheats["'"] = findNamedFile
cheats["m"] = { ":let @m=@+<cr>", ":let @m=@+" }
cheats["M"] = { 'viw"mp<cr>', 'viw"mp' }
cheats["a"] = { ":messages<cr>", ":messages" }
cheats["s"] = { ":let @+ = execute('messages')<cr>", ":let @+ = execute('messages')" }

whichKey.register(cheats, { prefix = "\\" })

if vim.g.knob_dap then
    local runners = {}
    runners["m"] = { "<cmd>lua require'dap'.continue()<CR>", "attach/continue" }
    runners["n"] = { "<cmd>lua require'dap'.run_last()<CR>", "terminate" }
    runners["b"] = { "<cmd>lua require'dap'.terminate()<CR>", "terminate" }
    runners["t"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "toggle breakpoint" }
    runners["y"] = { "<cmd>lua require'dap'.list_breakpoints()<CR>", "list breakpoints" }
    runners["h"] = { "<cmd>lua require'dap'.clear_breakpoints()<CR>", "clear breakpoints" }
    runners["g"] = { "<cmd>lua require'dap'.set_exception_breakpoints()<CR>", "exception breakpoints" }

    runners["z"] = { "<cmd>lua require'dap'.step_out()<CR>", "step out" }
    runners["x"] = { "<cmd>lua require'dap'.step_over()<CR>", "step over" }
    runners["c"] = { "<cmd>lua require'dap'.step_into()<CR>", "step into" }
    runners["a"] = { "<cmd>lua require'dap'.up()<CR>", "up stack" }
    runners["s"] = { "<cmd>lua require'dap'.down()<CR>", "down stack" }
    runners["v"] = { "<cmd>lua require'telescope'.extensions.dap.variables{}<CR>", "variables" }
    runners["r"] = { "<cmd>lua require'dap'.repl.open()<CR>", "REPL" }
    runners["d"] = { "<cmd>Telescope dap commands<CR>", "DAP commands" }
    runners["f"] = {
        "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
        "Scopes",
    }
    runners["o"] = { "<cmd>lua require'dapui'.open()<CR>", "UI Open" }

    runners["k"] = { "<cmd>lua require'dapui'.close()<CR>", "UI Close" }
    runners["i"] = { "<cmd>lua require'dapui'.toggle()<CR>", "UI Toggle" }
    runners["p"] = { "<cmd>lua require'dapui'.eval()<CR>", "Show Variable" }

    whichKey.register(runners, { prefix = "," })
end
