require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    always_show_bufferline = true,
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
-- I toggle tabline on in MobbingMode (with key map - <leader> 3) since tabline
-- is normally on useful to me when I'm screen sharing and I'd like others to
-- see files that are open
vim.opt.showtabline = 0
