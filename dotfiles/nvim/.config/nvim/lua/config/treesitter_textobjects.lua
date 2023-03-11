require("nvim-treesitter.configs").setup({
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = { query = "@class.inner", desc =
        "Select inner part of a class region" },
        ["as"] = { query = "@scope", query_group = "locals", desc =
        "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ["@parameter.outer"] = "v",         -- charwise
        ["@function.outer"] = "V",          -- linewise
        ["@class.outer"] = "<c-v>",         -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = true,
    },
    move = {
      enable = true,
      set_jumps = true,       -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]o"] = "@loop.*",
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
      -- goto_next = {
      --   ["]d"] = "@conditional.outer",
      -- },
      -- goto_previous = {
      --   ["[d"] = "@conditional.outer",
      -- },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>,ta"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>,tA"] = "@parameter.inner",
      },
    },
  },
})

local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
