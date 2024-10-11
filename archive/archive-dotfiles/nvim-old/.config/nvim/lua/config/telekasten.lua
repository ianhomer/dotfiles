local home = vim.fn.expand("~/projects/things")

require("telekasten").setup({
    home = home,
    take_over_my_home = false,
    dailies      = home .. '/my-notes/stream',
    weeklies     = home .. '/my-notes/stream',
    templates    = home .. '/my-notes/templates',
})
