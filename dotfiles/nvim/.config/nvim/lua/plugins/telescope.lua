return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-symbols.nvim" },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close
            -- ["<esc>"] = function() require("telescope.actions").close end,
          },
        },
        layout_strategy = "vertical",
        layout_config = {
          horizontal = {
            prompt_position = "bottom",
          },
          vertical = {
            mirror = false,
          },
          height = 0.99,
          width = 0.99,
        },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
    },

    keys = {
      {
        "<c-l>",
        mode = "i",
        "<cmd>lua require'telescope.builtin'.symbols{ sources = {'gitmoji'}}<cr>",
      },
    },
  },
  { "nvim-telescope/telescope-symbols.nvim" },
}
