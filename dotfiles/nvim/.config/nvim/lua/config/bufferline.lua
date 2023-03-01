require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    always_show_bufferline = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "Files",
        text_align = "center",
        separator = true,
      },
    },
  },
})
