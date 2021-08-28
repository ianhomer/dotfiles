local wk = require("which-key")

wk.setup {
}

wk.register({
  f = { "<cmd>Telescope find_files hidden=true<cr>", "Find File" }
}, { prefix = "<leader>" })
