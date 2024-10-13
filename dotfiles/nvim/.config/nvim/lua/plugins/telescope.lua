return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-symbols.nvim" },
    opts = function()
      local actions = require("telescope.actions")

      return {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
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
      }
    end,

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
