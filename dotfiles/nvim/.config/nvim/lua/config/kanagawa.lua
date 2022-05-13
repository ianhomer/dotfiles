vim.opt.fillchars:append({
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┨',
    vertright = '┣',
    verthoriz = '╋',
})

require('kanagawa').setup({
  dimInactive = true,
  globalStatus = true
})
vim.cmd("colorscheme kanagawa")

