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
  compile = true,
  undercurl = true,
  dimInactive = true,
  globalStatus = true,
  colors = my_colors,
  overrides = function(colors)
    local theme = colors.theme
    local infoColor = { bold = true, fg = theme.syn.special1 }
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
      IlluminatedWordWrite = { bg = theme.ui.bg_p1, fg = "NONE" },
      -- Use :Inspect to find the highlight name to help with customisation
      ["@markup.heading"] = infoColor,
      ["@markup.strong"] = infoColor,
      ["@markup.italic"] = infoColor,
      ["@markup.strikethrough"] = { strikethrough = true },
      ["@markup.raw.block"] = { fg = theme.syn.statement },
      ["@markup.list.unchecked"] = { bold = true }
    }
  end,
})
vim.cmd("colorscheme kanagawa")
