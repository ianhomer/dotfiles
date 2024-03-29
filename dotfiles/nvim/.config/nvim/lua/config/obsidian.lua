local my_frontmatter_func = function(note)
  -- Add the title of the note as an alias.
  if note.title then
    note:add_alias(note.title)
  end

  -- Add directories as tags
  local parent = note.path:parent()

  local relative = parent:relative_to(vim.fn.getcwd())
  for part in vim.gsplit(relative.filename, "/") do
    note:add_tag(part)
  end

  local out = { id = note.id, aliases = note.aliases, tags = note.tags }

  -- `note.metadata` contains any manually added fields in the frontmatter.
  -- So here we just make sure those fields are kept in the frontmatter.
  if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
    for k, v in pairs(note.metadata) do
      out[k] = v
    end
  end

  return out
end

require("obsidian").setup({
  daily_notes = {
    folder = "my-notes/stream",
    date_format = "%m%d",
    alias_format = "%a %d %b %Y",
  },
  disable_frontmatter = false,
  log_level = vim.log.levels.WARN,
  note_frontmatter_func = my_frontmatter_func,
  ui = {
    enable = true,
    checkboxes = {
      [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
      [">"] = { char = "", hl_group = "ObsidianRightArrow" },
      ["~"] = { char = "❎", hl_group = "ObsidianTilde" },
    },
  },
  workspaces = {
    {
      name = "things",
      path = "~/projects/things",
    },
  },
})
