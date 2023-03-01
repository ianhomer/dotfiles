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

local leaders = {}
local vmap = {}

-- Core navigation
whichKey.register{
  ["g"] = { name = "+goto" },
  ["]"] = { name = "+next" },
  ["["] = { name = "+prev" },
}

leaders["b"] = { name = "+buffer" }
leaders["c"] = { name = "+code" }
leaders["f"] = { name = "+find" }
leaders["g"] = { name = "+git" }
leaders["gh"] = { name = "+hunks" }
leaders["s"] = { name = "+search" }

local findNamedFile = {
    "<cmd>lua require'telescope.builtin'.find_files({find_command={'fd', '-H', '-i', vim.fn.expand('<cword>')}})<cr>",
    "Find named file",
}

if vim.g.knob_telescope then
    -- Alternatives
    leaders["tg"] = { "<cmd>Telescope grep_string<cr>", "Grep String" }

    -- Find
    leaders["<space>"] = { "<cmd>Telescope buffers<cr>", "Buffers" }
    leaders["F"] = { "<cmd>Telescope find_files hidden=true<cr>", "Find File" }
    leaders["ff"] = { "<cmd>Telescope find_files hidden=true<cr>", "Find File" }
    leaders["fh"] = { "<cmd>Telescope oldfiles only_cwd=true<cr>", "File History" }
    leaders["fH"] = { "<cmd>Telescope frecency<cr>", "Frequent" }
    leaders["fF"] = findNamedFile

    -- Search
    leaders["S"] = { "<cmd>Telescope live_grep<cr>", "Search" }
    leaders["ss"] = { "<cmd>Telescope live_grep<cr>", "Search" }
    leaders["sA"] = { "<cmd>Telescope live_grep hidden=true<cr>", "Search" }
    leaders["sS"] = { "<cmd>Fuzzy<cr>", "Fuzzy Search" }
    leaders["sa"] = { "<cmd>Telescope autocommands<cr>", "Auto Commands" }
    leaders["sb"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" }
    leaders["sc"] = { "<cmd>Telescope command_history<cr>", "Command History" }
    leaders["sC"] = { "<cmd>Telescope commands<cr>", "Commands" }
    leaders["sd"] = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" }
    leaders["sh"] = { "<cmd>Telescope help_tags<cr>", "Help Tags" }
    leaders["sH"] = { "<cmd>Telescope highlights<cr>", "Highlights" }
    leaders["sk"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" }
    leaders["sm"] = { "<cmd>Telescope marks<cr>", "Jump to Mark" }
    leaders["sM"] = { "<cmd>Telescope man_pages<cr>", "Man Pages" }
    leaders["so"] = { "<cmd>Telescope vim_options<cr>", "Options" }
    leaders["sR"] = { "<cmd>Telescope resume<cr>", "Resume" }
    leaders["st"] = { "<cmd>Telescope<cr>", "Telescope" }
    leaders["sT"] = { "<cmd>Telescope tags<cr>", "Tags" }
    leaders["sq"] = { "<cmd>Telescope quickfix<cr>", "Quick Fix" }
    leaders["sj"] = { "<cmd>Telescope jumplist<cr>", "Jump List" }
    leaders["sl"] = { "<cmd>Telescope loclist<cr>", "Location List" }
    leaders["sr"] = { "<cmd>Telescope registers<cr>", "Registers" }

    leaders["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search Buffer" }
    leaders["t4"] = { "<cmd>Telescope search_history<cr>", "Search History" }
    leaders["t9"] = { "<cmd>Telescope spell_suggest<cr>", "Spell Suggest" }

    -- Git
    leaders["tb"] = { "<cmd>Telescope git_bcommits<cr>", "Buffer Commits" }
    leaders["t1"] = { "<cmd>Telescope git_commits<cr>", "Git Commits" }
    leaders["t2"] = { "<cmd>Telescope: git_branches<cr>", "Git Branches" }
    leaders["t3"] = { "<cmd>Telescope git_stash<cr>", "Git Stash" }

    -- LSP
    leaders["td"] = { "<cmd>Telescope lsp_document_symbols<cr>", "LSP document symbols" }
end

leaders[";"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "LSP Format" }
leaders[":"] = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "LSP Range Format" }

-- Modes
leaders["5"] = { "<cmd>lua require'config/null_ls'.setLevel(3)<cr>", "Core Lints" }
leaders["6"] = { "<cmd>lua require'config/null_ls'.toggle()<cr>", "Toggle Lints" }
leaders["7"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble File" }
leaders["&"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble All" }
leaders["8"] = { "<cmd>call my#ToggleBlame()<cr>", "Blame" }
leaders["9"] = { "<cmd>set wrap! | set wrap?<cr>", "Wrap" }

leaders["m"] = { "<cmd>lua require'codewindow'.toggle_minimap()<cr>", "Minimap" }
leaders["rg"] = { ":reg<cr>", "Registers" }

-- Dev
leaders["y"] = { "<cmd>TestNearest<cr>", "Test nearest" }
leaders["Y"] = { "<cmd>TestFile<cr>", "Test file" }
leaders["q"] = { vim.diagnostic.setloclist, "Set Loc List" }

if vim.g.knob_toggleterm then
    leaders["a"] = { "<cmd>ToggleTerm<cr>", "Terminal" }
end

if vim.g.knob_nvim_tree then
    leaders["n"] = { "<cmd>NvimTreeToggle<cr>", "Files" }
end

if vim.g.knob_peek then
    leaders["p"] = { "<cmd>PeekOpen<cr>", "Markdown Peek"}
end

leaders["e"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Diagnostics" }
leaders["cc"] = { "beli<cmd>lua require'cmp'.complete()<cr>", "Autocompletion menu"}
if vim.g.knob_hop then
    leaders["h"] = { "<cmd>lua require'hop'.hint_words()<cr>", "Hop" }
end

if vim.g.knob_refactoring then
    leaders["rc"] = { ":lua require('refactoring').debug.cleanup({})<cr>", "Refactor debug cleanup" }
    leaders["rn"] =
        { ":lua require('refactoring').debug.print_var({ normal = true })<cr>", "Refactor debug print variable" }

    leaders["rb"] = { [[ <cmd>lua require('refactoring').refactor('Extract Block')<cr>]], "Extract Block" }
    leaders["rbf"] = { [[ <cmd>lua require('refactoring').refactor('Extract Block To File')<cr>]], "Extract Block to File" }
    leaders["ri"] = { [[ <cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" }
    leaders["rd"] =
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

whichKey.register(leaders, { prefix = "<leader>" })
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
