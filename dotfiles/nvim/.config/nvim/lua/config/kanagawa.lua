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
  bg = "#16161D",
  samuraiRed = "#dddddd"
}

require('kanagawa').setup({
  undercurl = true,
  dimInactive = true,
  globalStatus = true,
  colors = my_colors,
  overrides = {
    WinSeparator  = { fg = "#223249", bg = "NONE" },
    VertSplit  = { fg = "#223249", bg = "NONE" },
    -- darken current window beyond default palette
    Normal = { bg = "#121218" },
  }
})
vim.cmd("colorscheme kanagawa")

