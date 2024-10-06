local whichKey = require("which-key")
whichKey.setup({
  delay = 2000,
  plugins = {
    spelling = {
      enabled = true,
    },
  },
  win = {
    height = { min = 4, max = 8 }, -- min and max height of the columns
    border = "single", -- none, single, double, shadow
    padding = { 0, 2, 1, 0 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    width = { min = 30, max = 50 }, -- min and max width of the columns
    spacing = 2, -- spacing between columns
  },
})

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

-- local findNamedFile = {
--   "<cmd>lua require'telescope.builtin'.find_files({find_command={'fd', '-H', '-i', vim.fn.expand('<cword>')}})<cr>",
--   "Find named file",
-- }

local my = require("myutils")
whichKey.add({
  { "<leader>,xa", "<cmd>CloseTerms<cr> | :xa<cr>", desc = "Exit Vim" },
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
    -- { "<leader>,fF", findNamedFile, desc = "Find named file" },
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
    { "<leader>,sL", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP document symbols" },
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
  whichKey.add({
    { "<leader>a", "<cmd>CodeCompanionToggle<cr>", desc = "AI" },
  })
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
    { "<leader>,xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    { "<leader>,xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
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

  whichKey.add({
    {
      mode = "v",
      {
        "re",
        [[ <esc><cmd>lua require('refactoring').refactor('Extract Function')<cr>]],
        desc = "Extract function",
      },
      {
        "rr",
        "<esc><cmd>lua require('telescope').extensions.refactoring.refactors()<cr>",
        desc = "Refactor select",
      },
      {
        "rd",
        ":lua require('refactoring').debug.print_var({ normal = true})<cr>",
        desc = "Refactor debug print variable",
      },

      {
        "rf",
        [[ <esc><cmd>lua require('refactoring').refactor('Extract Function To File')<cr>]],
        desc = "Extract function to file",
      },
      {
        "rv",
        [[<esc><cmd>lua require('refactoring').refactor('Extract Variable')<cr>]],
        desc = "Extract variable",
      },
      {
        "ri",
        [[ <esc><cmd>lua require('refactoring').refactor('Inline Variable')<cr>]],
        desc = "Inline variable",
      },
    },
  })
end


whichKey.add({
  -- { "\\'", findNamedFile },
  { "\\m", ":let @m=@+<cr>", desc = ":let @m=@+" },
  { "\\M", 'viw"mp<cr>', desc = 'viw"mp' },
  { "\\a", ":messages<cr>", desc = ":messages" },
  { "\\s", ":let @+ = execute('messages')<cr>", desc = ":let @+ = execute('messages')" },
  { "\\T", "<cmd>let test#project_root=@0<cr>", desc = "Test dir to clipboard" },
})

whichKey.add({
  { "gw", ":FindWord<cr>", desc = "Find word" },
  { "gW", ":GrepWord<cr>", desc = "Grep word" },
})

if vim.g.knob_dap then
  whichKey.add({
    { "<leader>xm", "<cmd>lua require'dap'.continue()<CR>", desc = "continue (F8)" },

    { "<leader>xn", "<cmd>lua require'dap'.run_last()<CR>", desc = "terminate" },
    { "<leader>xb", "<cmd>lua require'dap'.terminate()<CR>", desc = "terminate" },
    { "<leader>xt", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "toggle breakpoint" },
    { "<leader>xy", "<cmd>lua require'dap'.list_breakpoints()<CR>", desc = "list breakpoints" },
    { "<leader>xh", "<cmd>lua require'dap'.clear_breakpoints()<CR>", desc = "clear breakpoints" },
    { "<leader>xg", "<cmd>lua require'dap'.set_exception_breakpoints()<CR>", desc = "exception breakpoints" },

    { "<leader>xz", "<cmd>lua require'dap'.step_out()<CR>", desc = "step out" },
    { "<leader>xx", "<cmd>lua require'dap'.step_over()<CR>", desc = "step over" },

    { "<leader>xc", "<cmd>lua require'dap'.step_into()<CR>", desc = "step into" },
    { "<leader>xa", "<cmd>lua require'dap'.up()<CR>", desc = "up stack" },
    { "<leader>xs", "<cmd>lua require'dap'.down()<CR>", desc = "down stack" },
    { "<leader>xv", "<cmd>lua require'telescope'.extensions.dap.variables{}<CR>", desc = "variables" },
    { "<leader>xr", "<cmd>lua require'dap'.repl.open()<CR>", desc = "REPL" },
    { "<leader>xd", "<cmd>Telescope dap commands<CR>", desc = "DAP commands" },
    {
      "<leader>xf",
      "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
      desc = "Scopes",
    },
    { "<leader>xo", "<cmd>lua require'dapui'.open()<CR>", desc = "UI Open" },
    { "<leader>xk", "<cmd>lua require'dapui'.close()<CR>", desc = "UI Close" },
    { "<leader>xi", "<cmd>lua require'dapui'.toggle()<CR>", desc = "UI Toggle" },
    { "<leader>xp", "<cmd>lua require'dapui'.eval()<CR>", desc = "Show Variable" },
  })

  vim.keymap.set("n", "<F8>", "<cmd>lua require'dap'.continue()<CR>")
  vim.keymap.set("n", "<F9>", "<cmd>lua require'dap'.step_over()<CR>")
end

if vim.g.knob_neoscroll then
  -- neoscroll takes over scrolling short cuts
  whichKey.add({
    { "<c-f>", desc = "⬇" }, -- page down
    { "<c-d>", desc = "⇩" }, -- page half down
    { "<c-e>", desc = "↓" }, -- line down
    { "<c-b>", desc = "⬆" }, -- page up
    { "<c-u>", desc = "⇧" }, -- page half up
    { "<c-y>", desc = "↑" }, -- line up
  })
end
whichKey.add({
  { "<cr>", desc = "Start select block" },
  { "%", desc = "Jump bracket" },
  { "s", desc = "Jump lightspeed" },
  { "S", desc = "Jump back lightspeed" },
  { "^", desc = "Start of line" },
  { "!", desc = "External program" },
})
