return {
  "folke/noice.nvim",
  opts = {
    views = {
      cmdline_popup = {
        position = {
          row = "99%",
          col = "0",
        },
        size = {
          width = "100%",
        },
        border = {
          style = "none",
          padding = { 0, 0 },
        },
        filter_options = {},
        win_options = {
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
      },
    },
    cmdline = {
      enabled = true,
      view = "cmdline",
      format = {
        cmdline = { pattern = "^:", icon = ":", lang = "vim" },
      },
    },
  },
}
