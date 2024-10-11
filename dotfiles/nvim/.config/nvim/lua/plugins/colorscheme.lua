return {
  {
    "rebelot/kanagawa.nvim",
    priority = 90,
    config = function()
      require("config.kanagawa")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
