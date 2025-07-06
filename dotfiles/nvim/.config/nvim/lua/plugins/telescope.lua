local function find_command()
  if 1 == vim.fn.executable("rg") then
    return {
      "rg",
      "--files",
      "--color",
      "never",
      "-g",
      "!.git",
      "--ignore-file",
      os.getenv("HOME") .. "/.config/rg/nvim-telescope-lesser.ignore",
    }
  elseif 1 == vim.fn.executable("fd") then
    return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
  elseif 1 == vim.fn.executable("fdfind") then
    return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
  elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
    return { "find", ".", "-type", "f" }
  elseif 1 == vim.fn.executable("where") then
    return { "where", "/r", ".", "*" }
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-symbols.nvim" },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
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
        border = true,
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
        },
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
