vim.opt.fillchars:append({
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┨',
    vertright = '┣',
    verthoriz = '╋',
})

local my_colors = {
  bg = "#16161D"
}

require('kanagawa').setup({
  dimInactive = false,
  globalStatus = true,
  colors = my_colors,
  overrides = {
    WinSeparator  = { fg = "#223249", bg = "NONE" },
    VertSplit  = { fg = "#223249", bg = "NONE" },
  }
})
vim.cmd("colorscheme kanagawa")

