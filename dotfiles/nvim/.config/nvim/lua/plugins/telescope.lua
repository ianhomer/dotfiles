return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-symbols.nvim" },
    opts = {
      defaults = {
        mappings = {
          i = {
            -- ["<esc>"] = require("telescope.actions").close,
            -- ["<esc>"] = function() require("telescope.actions").close end,
          },
        },
        layout_config = {
          horizontal = { prompt_position = "top" },
          vertical = {
            mirror = false,
          },
          height = 0.80,
          width = 0.80,
        },
        winblend = 0,
        file_ignore_patterns = { "%.png", "%.note", ".DS_Store" },
        border = true,
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
