require("codecompanion").setup({
  strategies = {
    chat = "ollama",
    inline = "ollama",
    tools = "ollama"
  },
  display = {
    chat = {
      type = "float",
      float_options = {
        max_height=0,
        max_width=0
      }
    }

  }
})
