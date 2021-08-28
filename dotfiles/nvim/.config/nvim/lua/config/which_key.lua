local wk = require("which-key")

wk.setup {
  plugins = {
    marks = true
  }
}

wk.register({
  f = { "<cmd>Telescope find_files<cr>", "Find File" }
}, { prefix = "<leader>" })
