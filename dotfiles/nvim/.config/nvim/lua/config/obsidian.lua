require("obsidian").setup({
  daily_notes = {
    folder = "my-notes/stream",
    date_format = "%m%d",
    alias_format = "%a %d %b %Y",
  },
  disable_frontmatter = true,
  log_level = vim.log.levels.WARN,
  ui = {
    enable = true,
  },
  workspaces = {
    {
      name = "things",
      path = "~/projects/things",
    },
  },
})
