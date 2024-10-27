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
      style = "none",
    },
    checkbox = {
      position = "overlay",
    },
    link = {
      enabled = false,
    },
    pipe_table = {
      cell = 'overlay'
    },
    win_options = {
      conceallevel = {
        rendered = 1,
      },
    },
  },
}
