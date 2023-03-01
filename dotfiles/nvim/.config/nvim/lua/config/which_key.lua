local whichKey = require("which-key")
whichKey.setup({
    plugins = {
        spelling = {
            enabled = true,
        },
    },
    window = {
        border = "single", -- none, single, double, shadow
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
local vmap = {}

local findNamedFile = {
    "<cmd>lua require'telescope.builtin'.find_files({find_command={'fd', '-H', '-i', vim.fn.expand('<cword>')}})<cr>",
    "Find named file",
}

if vim.g.knob_telescope then
    -- Common Searches
    map["f"] = { "<cmd>Telescope find_files hidden=true<cr>", "Find File" }
    map["h"] = { "<cmd>Telescope oldfiles only_cwd=true<cr>", "File History" }
    map["H"] = { "<cmd>Telescope frecency<cr>", "Frequent" }
    map["<space>"] = { "<cmd>Telescope buffers<cr>", "Buffers" }

    -- Alternatives
    map["tS"] = { "<cmd>Telescope live_grep hidden=true<cr>", "Search" }
    map["tg"] = { "<cmd>Telescope grep_string<cr>", "Grep String" }

    -- File
    map["tf"] = findNamedFile
    map["tF"] = { "<cmd>Telescope file_browser<cr>", "File Browser" }

    -- Search
    map["s"] = { name = "+search" }
    map["S"] = { "<cmd>Telescope live_grep<cr>", "Search" }
    map["ss"] = { "<cmd>Telescope live_grep<cr>", "Search" }
    map["sS"] = { "<cmd>Fuzzy<cr>", "Fuzzy Search" }
    map["sa"] = { "<cmd>Telescope autocommands<cr>", "Auto Commands" }
    map["sb"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" }
    map["sc"] = { "<cmd>Telescope command_history<cr>", "Command History" }
    map["sC"] = { "<cmd>Telescope commands<cr>", "Commands" }
    map["sd"] = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" }
    map["sh"] = { "<cmd>Telescope help_tags<cr>", "Help Tags" }
    map["sH"] = { "<cmd>Telescope highlights<cr>", "Highlights" }
    map["sk"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" }
    map["sm"] = { "<cmd>Telescope marks<cr>", "Jump to Mark" }
    map["sM"] = { "<cmd>Telescope man_pages<cr>", "Man Pages" }
    map["so"] = { "<cmd>Telescope vim_options<cr>", "Options" }
    map["sR"] = { "<cmd>Telescope resume<cr>", "Resume" }
    map["st"] = { "<cmd>Telescope<cr>", "Telescope" }
    map["sT"] = { "<cmd>Telescope tags<cr>", "Tags" }
    map["sq"] = { "<cmd>Telescope quickfix<cr>", "Quick Fix" }
    map["sj"] = { "<cmd>Telescope jumplist<cr>", "Jump List" }
    map["sl"] = { "<cmd>Telescope loclist<cr>", "Location List" }
    map["sr"] = { "<cmd>Telescope registers<cr>", "Registers" }

    map["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search Buffer" }
    map["t4"] = { "<cmd>Telescope search_history<cr>", "Search History" }
    map["t9"] = { "<cmd>Telescope spell_suggest<cr>", "Spell Suggest" }

    -- Git
    map["tb"] = { "<cmd>Telescope git_bcommits<cr>", "Buffer Commits" }
    map["t1"] = { "<cmd>Telescope git_commits<cr>", "Git Commits" }
    map["t2"] = { "<cmd>Telescope: git_branches<cr>", "Git Branches" }
    map["t3"] = { "<cmd>Telescope git_stash<cr>", "Git Stash" }

    -- LSP
    map["td"] = { "<cmd>Telescope lsp_document_symbols<cr>", "LSP document symbols" }
end

map[";"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "LSP Format" }
map[":"] = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "LSP Range Format" }

-- Modes
map["5"] = { "<cmd>lua require'config/null_ls'.setLevel(3)<cr>", "Core Lints" }
map["6"] = { "<cmd>lua require'config/null_ls'.toggle()<cr>", "Toggle Lints" }
map["7"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble File" }
map["&"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble All" }
map["8"] = { "<cmd>call my#ToggleBlame()<cr>", "Blame" }
map["9"] = { "<cmd>set wrap! | set wrap?<cr>", "Wrap" }

map["m"] = { "<cmd>lua require'codewindow'.toggle_minimap()<cr>", "Minimap" }
map["rg"] = { ":reg<cr>", "Registers" }

-- Dev
map["y"] = { "<cmd>TestNearest<cr>", "Test nearest" }
map["Y"] = { "<cmd>TestFile<cr>", "Test file" }
map["q"] = { vim.diagnostic.setloclist, "Set Loc List" }

if vim.g.knob_toggleterm then
    map["a"] = { "<cmd>ToggleTerm<cr>", "Terminal" }
end

if vim.g.knob_nvim_tree then
    map["n"] = { "<cmd>NvimTreeToggle<cr>", "Files" }
end

if vim.g.knob_peek then
    map["p"] = { "<cmd>PeekOpen<cr>", "Markdown Peek"}
end

map["e"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Diagnostics" }
map["cc"] = { "beli<cmd>lua require'cmp'.complete()<cr>", "Autocompletion menu"}
if vim.g.knob_hop then
    map["h"] = { "<cmd>lua require'hop'.hint_words()<cr>", "Hop" }
end

if vim.g.knob_refactoring then
    map["rc"] = { ":lua require('refactoring').debug.cleanup({})<cr>", "Refactor debug cleanup" }
    map["rn"] =
        { ":lua require('refactoring').debug.print_var({ normal = true })<cr>", "Refactor debug print variable" }

    map["rb"] = { [[ <cmd>lua require('refactoring').refactor('Extract Block')<cr>]], "Extract Block" }
    map["rbf"] = { [[ <cmd>lua require('refactoring').refactor('Extract Block To File')<cr>]], "Extract Block to File" }
    map["ri"] = { [[ <cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" }
    map["rd"] =
        { ":lua require('refactoring').debug.print_var({ normal = true })<cr>", "Refactor debug print variable" }

    vmap["re"] = { [[ <esc><cmd>lua require('refactoring').refactor('Extract Function')<cr>]], "Extract function" }
    vmap["rr"] = { "<esc><cmd>lua require('telescope').extensions.refactoring.refactors()<cr>", "Refactor select" }
    vmap["rd"] =
        { ":lua require('refactoring').debug.print_var({ normal = true})<cr>", "Refactor debug print variable" }

    vmap["rf"] = {
        [[ <esc><cmd>lua require('refactoring').refactor('Extract Function To File')<cr>]],
        "Extract function to file",
    }
    vmap["rv"] = { [[<esc><cmd>lua require('refactoring').refactor('Extract Variable')<cr>]], "Extract variable" }
    vmap["ri"] = { [[ <esc><cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline variable" }
end

whichKey.register(map, { prefix = "<leader>" })
whichKey.register(vmap, { prefix = "<leader>", mode = "v" })

local cheats = {}
cheats["'"] = findNamedFile
cheats["m"] = { ":let @m=@+<cr>", ":let @m=@+" }
cheats["M"] = { 'viw"mp<cr>', 'viw"mp' }
cheats["a"] = { ":messages<cr>", ":messages" }
cheats["s"] = { ":let @+ = execute('messages')<cr>", ":let @+ = execute('messages')" }
cheats["T"] = { "<cmd>let test#project_root=@0<cr>", "Test dir to clipboard" }


whichKey.register(cheats, { prefix = "\\" })

local goes = {}
goes["w"] = { ":FindWord<cr>", "Find word" }
goes["W"] = { ":GrepWord<cr>", "Grep word" }
whichKey.register(goes, { prefix = "g" })

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
