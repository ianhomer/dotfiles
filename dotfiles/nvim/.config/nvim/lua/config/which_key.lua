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
local extras = {}
local vmap = {}

-- Core navigation
whichKey.add({
  { "/", group = "extras" },
  { "[", group = "prev" },
  { "]", group = "next" },
  { "g", group = "goto" },
  { "u", group = "ui" },
})

whichKey.add({
  { "<leader>c", group = "code" },
  { "<leader>j", group = "thingity" },
  { "<leader>/", group = "extras" },
  { "<leader>x", group = "fix" },
})

whichKey.add({
  { "<leader>,b", group = "buffer" },
  { "<leader>,f", group = "find" },
  { "<leader>,g", group = "git" },
  { "<leader>,gh", group = "hunks" },
  { "<leader>,gd", group = "diff" },
  { "<leader>,s", group = "search" },
  { "<leader>,.", group = "profile" },
})

local findNamedFile = {
  "<cmd>lua require'telescope.builtin'.find_files({find_command={'fd', '-H', '-i', vim.fn.expand('<cword>')}})<cr>",
  "Find named file",
}

local my = require("myutils")
whichKey.add({
  { "<leader>xa", "<cmd>CloseTerms<cr> | :xa<cr>", desc = "Exit Vim" },
  { "<leader>us", my.toggle_function("spell"), desc = "Toggle spell" },
  { "<leader>uw", my.toggle_function("wrap"), desc = "Toggle wrap" },
})

if vim.g.knob_telescope then
  -- Find
  whichKey.add({
    { "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>f", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find file" },
    { "<leader>h", "<cmd>Telescope oldfiles only_cwd=true<cr>", desc = "File history" },
    { "<leader>,fH", "<cmd>Telescope frecency<cr>", desc = "Frequent" },
    { "<leader>,fF", findNamedFile, desc = "Find named file" },
  })

  -- Search
  whichKey.add({
    { "<leader>s", "<cmd>Telescope live_grep<cr>", desc = "Search" },
    { "<leader>,sA", "<cmd>Telescope live_grep hidden=true<cr>", desc = "Search" },
    { "<leader>,sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>,sH", "<cmd>Telescope highlights<cr>", desc = "Highlights" },
    { "<leader>,sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>,sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>,sS", "<cmd>Fuzzy<cr>", desc = "Fuzzy Search" },
    { "<leader>,sT", "<cmd>Telescope tags<cr>", desc = "Tags" },
    { "<leader>,sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>,sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>,sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>,sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>,sh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    { "<leader>,sj", "<cmd>Telescope jumplist<cr>", desc = "Jump List" },
    { "<leader>,sg", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
    { "<leader>,sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>,sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
    { "<leader>,sl", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP document symbols" },
    { "<leader>,sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>,so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>,sq", "<cmd>Telescope quickfix<cr>", desc = "Quick Fix" },
    { "<leader>,sr", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>,st", "<cmd>Telescope<cr>", desc = "Telescope" },
    { "<leader>,sx", ":reg<cr>", desc = "Registers (:reg)" },
    { "<leader>,s4", "<cmd>Telescope search_history<cr>", desc = "Search History" },
    { "<leader>,s9", "<cmd>Telescope spell_suggest<cr>", desc = "Spell Suggest" },
  })

  -- Git
  whichKey.add({
    { "<leader>,gtb", "<cmd>Telescope git_bcommits<cr>", desc = "Buffer Commits" },
    { "<leader>,gt1", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
    { "<leader>,gt2", "<cmd>Telescope: git_branches<cr>", desc = "Git Branches" },
    { "<leader>,gt3", "<cmd>Telescope git_stash<cr>", desc = "Git Stash" },
  })

  -- UI
  whichKey.add({
    { "<leader>,uz", "<cmd>ZenMode<cr>", desc = "Zen mode" },
  })
end

whichKey.add({
  { "<leader>;", "<cmd>lua vim.lsp.buf.formatting()<cr>", desc = "LSP Format" },
  { "<leader>:", "<cmd>lua vim.lsp.buf.range_formatting()<cr>", desc = "LSP Range Format" },
})

-- Modes
whichKey.add({
  { "<leader>5", "<cmd>lua require'config/none_ls'.setLevel(3)<cr>", desc = "Core Lints" },
  { "<leader>6", "<cmd>lua require'config/none_ls'.toggle()<cr>", desc = "Toggle Lints" },
  { "<leader>7", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble File" },
  { "<leader>&", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble All" },
  { "<leader>8", "<cmd>call my#ToggleBlame()<cr>", desc = "Blame" },
  { "<leader>9", "<cmd>set wrap! | set wrap?<cr>", desc = "Wrap" },
})

if vim.g.knob_codewindow then
  whichKey.add({ { "<leader>m", "<cmd>lua require'codewindow'.toggle_minimap()<cr>", desc = "Minimap" } })
end

-- Dev
whichKey.add({
  { "<leader>y", "<cmd>TestNearest<cr>", desc = "Test nearest" },
  { "<leader>Y", "<cmd>TestFile<cr>", desc = "Test file" },
  { "<leader>q", vim.diagnostic.setloclist, desc = "Set Loc List" },
})

if vim.g.knob_codecompanion then
  vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
  leaders["a"] = { "<cmd>CodeCompanionToggle<cr>", "AI" }
  vmap = leaders["a"]
end

if vim.g.knob_toggleterm then
  whichKey.add({ { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Terminal" } })
end

if vim.g.knob_nvim_tree then
  whichKey.add({ { "<leader>n", "<cmd>NvimTreeToggle<cr>", desc = "Files" } })
end

if vim.g.knob_peek then
  whichKey.add({ { "<leader>p", "<cmd>PeekOpen<cr>", desc = "Markdown Peek" } })
end

if vim.g.knob_trouble then
  whichKey.add({
    { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
  })
end

whichKey.add({
  { "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Diagnostics" },
  { "<leader>cc", "<cmd>lua require'cmp'.complete()<cr>", desc = "Autocompletion menu" },
})

if vim.g.knob_hop then
  whichKey.add({
    { "<leader>h", "<cmd>lua require'hop'.hint_words()<cr>", desc = "Hop" },
  })
end

if vim.g.knob_refactoring then
  whichKey.add({
    { "<leader>rc", ":lua require('refactoring').debug.cleanup({})<cr>", desc = "Refactor debug cleanup" },
    {
      "<leader>rn",
      ":lua require('refactoring').debug.print_var({ normal = true })<cr>",
      desc = "Refactor debug print variable",
    },

    {
      "<leader>rb",
      [[ <cmd>lua require('refactoring').refactor('Extract Block')<cr>]],
      desc = "Extract Block",
    },
    {
      "<leader>rbf",
      [[ <cmd>lua require('refactoring').refactor('Extract Block To File')<cr>]],
      desc = "Extract Block to File",
    },
    {
      "<leader>ri",
      [[ <cmd>lua require('refactoring').refactor('Inline Variable')<cr>]],
      desc = "Inline Variable",
    },
    {
      "<leader>rd",
      ":lua require('refactoring').debug.print_var({ normal = true })<cr>",
      desc = "Refactor debug print variable",
    },
  })

  vmap["re"] = {
    [[ <esc><cmd>lua require('refactoring').refactor('Extract Function')<cr>]],
    "Extract function",
  }
  vmap["rr"] = {
    "<esc><cmd>lua require('telescope').extensions.refactoring.refactors()<cr>",
    "Refactor select",
  }
  vmap["rd"] = { ":lua require('refactoring').debug.print_var({ normal = true})<cr>", "Refactor debug print variable" }

  vmap["rf"] = {
    [[ <esc><cmd>lua require('refactoring').refactor('Extract Function To File')<cr>]],
    "Extract function to file",
  }
  vmap["rv"] = {
    [[<esc><cmd>lua require('refactoring').refactor('Extract Variable')<cr>]],
    "Extract variable",
  }
  vmap["ri"] = {
    [[ <esc><cmd>lua require('refactoring').refactor('Inline Variable')<cr>]],
    "Inline variable",
  }
end

whichKey.register(leaders, { prefix = "<leader>" })
whichKey.register(extras, { prefix = "<leader>," })
whichKey.register(vmap, { prefix = "<leader>", mode = "v" })

local cheats = {}
cheats["'"] = findNamedFile
cheats["m"] = { ":let @m=@+<cr>", ":let @m=@+" }
cheats["M"] = { 'viw"mp<cr>', 'viw"mp' }
cheats["a"] = { ":messages<cr>", ":messages" }
cheats["s"] = { ":let @+ = execute('messages')<cr>", ":let @+ = execute('messages')" }
cheats["T"] = { "<cmd>let test#project_root=@0<cr>", "Test dir to clipboard" }

whichKey.register(cheats, { prefix = "\\" })

whichKey.add({
  { "gw", ":FindWord<cr>", desc = "Find word" },
  { "gW", ":GrepWord<cr>", desc = "Grep word" },
})

if vim.g.knob_dap then
  local runners = {}
  runners["m"] = { "<cmd>lua require'dap'.continue()<CR>", "continue (F8)" }
  vim.keymap.set("n", "<F8>", "<cmd>lua require'dap'.continue()<CR>")

  runners["n"] = { "<cmd>lua require'dap'.run_last()<CR>", "terminate" }
  runners["b"] = { "<cmd>lua require'dap'.terminate()<CR>", "terminate" }
  runners["t"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "toggle breakpoint" }
  runners["y"] = { "<cmd>lua require'dap'.list_breakpoints()<CR>", "list breakpoints" }
  runners["h"] = { "<cmd>lua require'dap'.clear_breakpoints()<CR>", "clear breakpoints" }
  runners["g"] = { "<cmd>lua require'dap'.set_exception_breakpoints()<CR>", "exception breakpoints" }

  runners["z"] = { "<cmd>lua require'dap'.step_out()<CR>", "step out" }
  runners["x"] = { "<cmd>lua require'dap'.step_over()<CR>", "step over" }
  vim.keymap.set("n", "<F9>", "<cmd>lua require'dap'.step_over()<CR>")

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

  whichKey.register(runners, { prefix = "<leader>x" })
end

local augmentExisting = {}
if vim.g.knob_neoscroll then
  -- neoscroll takes over scrolling short cuts
  augmentExisting["<c-f>"] = { desc = "⬇" } -- page down
  augmentExisting["<c-d>"] = { desc = "⇩" } -- page half down
  augmentExisting["<c-e>"] = { desc = "↓" } -- line down
  augmentExisting["<c-b>"] = { desc = "⬆" } -- page up
  augmentExisting["<c-u>"] = { desc = "⇧" } -- page half up
  augmentExisting["<c-y>"] = { desc = "↑" } -- line up
end
augmentExisting["<cr>"] = { desc = "Start select block" }
augmentExisting["%"] = { desc = "Jump bracket" }
augmentExisting["s"] = { desc = "Jump lightspeed" }
augmentExisting["S"] = { desc = "Jump back lightspeed" }
augmentExisting["^"] = { desc = "Start of line" }
augmentExisting["!"] = { desc = "External program" }

whichKey.register(augmentExisting)
