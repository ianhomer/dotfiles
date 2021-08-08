require("zen-mode").setup {
  window = {
    width = 90,
    options = {
      signcolumn = "no",
      number = false
    },
  },
  plugins = {
    tmux = { enabled = true }
  }
}

