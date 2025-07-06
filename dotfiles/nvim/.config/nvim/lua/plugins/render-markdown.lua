-- see https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki
return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    enabled = true,
    anti_conceal = {
      enabled = true,
      above = 0,
      below = 0,
    },
    heading = {
      sign = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },
    code = {
      sign = "true",
      style = "full",
      width = "block",
      min_width = 80,
      -- stop vertical jitter on scroll, see https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/430
      border = "thin",
    },
    checkbox = {
      position = "overlay",
    },
    link = {
      enabled = true,
    },
    pipe_table = {
      cell = "overlay",
    },
  },
}
