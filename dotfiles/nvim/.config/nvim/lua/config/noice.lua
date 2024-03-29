require("noice").setup({
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
  lsp_progress = {
    enabled = false,
  },
  messages = {
    -- enable when fix vertical scroll and redraw issue
    enabled = true,
    view = "mini",
    view_warn = "mini",
    view_error = "mini",
  },
  history = {
    view = "split",
    opts = { enter = true, format = "details" },
    filter = {
      event = { "msg_show", "notify" },
      ["not"] = { kind = { "search_count" } },
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
  },
})
