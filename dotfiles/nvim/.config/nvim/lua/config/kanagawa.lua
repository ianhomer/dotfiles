vim.opt.fillchars:append({
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
})

local my_colors = {
  palette = {
    bg = "#16161D",
    samuraiRed = "#dddddd",
  },
}

require("kanagawa").setup({
  undercurl = true,
  dimInactive = true,
  globalStatus = true,
  colors = my_colors,
  overrides = function(colors)
    local theme = colors.theme
    return {
      WinSeparator = { fg = "#223249", bg = "NONE" },
      VertSplit = { fg = "#223249", bg = "NONE" },
      -- darken current window beyond default palette
      Normal = { bg = "#121218" },
      TelescopeTitle = { fg = theme.ui.special, bold = true },
      TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
      TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
      IlluminatedWordText = { bg = theme.ui.bg_p1, fg = "NONE" },
      IlluminatedWordRead = { bg = theme.ui.bg_p1, fg = "NONE" },
      IlluminatedWordWrite = { bg = theme.ui.bg_p1, fg = "NONE" }
    }
  end,
})
vim.cmd("colorscheme kanagawa")
