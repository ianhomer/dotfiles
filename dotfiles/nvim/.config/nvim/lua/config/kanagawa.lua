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
  dimInactive = true,
  globalStatus = true,
  colors = my_colors,
  overrides = {
    WinSeparator  = { fg = "#223249", bg = "NONE" },
    VertSplit  = { fg = "#223249", bg = "NONE" },
    -- darken current window beyond default palette
    Normal = { bg = "#0f0f13" },
  }
})
vim.cmd("colorscheme kanagawa")

