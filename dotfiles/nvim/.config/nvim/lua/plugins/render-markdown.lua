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
      icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    },
    code = {
      sign = "true",
      style = "full",
      width = "block",
      min_width = 80
    },
    checkbox = {
      position = "overlay",
    },
    link = {
      enabled = true,
    },
    pipe_table = {
      cell = 'overlay'
    },
  },
}
