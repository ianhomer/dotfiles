local function repositoryName()
  local filename = vim.fn.expand("%:p")
  local _, j = string.find(filename, "projects/things/")
  if j and j > 0 then
    local k, _ = string.find(filename, "/", j + 1)
    if k > 0 then
      return filename.sub(filename, j + 1, k - 1)
    end
  end
  return nil
end

local function decoratedRepositoryName()
  local name = repositoryName()
  if name and name:match('^my-') then
     return  "🔒" .. name
  end
  return name
end

local function repositoryNameColor()
  local name = repositoryName()
  if name and name:match('^my-') then
    return { bg = 255, fg = 0, gui = "bold" }
  end
  return { fg = 225, gui = "bold" }
end

local function dapStatus()
  if not vim.g.knob_dap then
    return ""
  end
  return require('dap').status()
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local has_kanagawa, kanagawa = pcall(require, "lualine.themes.kanagawa")
if has_kanagawa then
  kanagawa.inactive.a.bg = kanagawa.normal.b.bg
  kanagawa.inactive.b.bg = kanagawa.normal.b.bg
  kanagawa.inactive.c.bg = kanagawa.normal.b.bg
end

require("lualine").setup({
  options = {
    -- => localstatus = 3
    globalstatus = true,
    theme = kanagawa,
    -- ignore focus changes into DAP UI elements, so that the initial
    -- filename remains in lualine
    ignore_focus = {
      "dapui_watches",
      "dapui_breakpoints",
      "dapui_scopes",
      "dapui_console",
      "dapui_stacks",
      "dap-repl",
    },
  },
  extensions = {
    "fugitive",
    "fzf",
    "mundo",
    "nvim-dap-ui",
    "nvim-tree",
    "toggleterm",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      { decoratedRepositoryName, color = repositoryNameColor },
      { dapStatus },
      { "diff",         source = diff_source },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        diagnostics_color = {
          error = "white",
        },
      },
    },
    lualine_x = { { "filetype", icon_only = true } },
    lualine_y = { "progress" },
    lualine_z = { "location",
      { "filename", symbols = { readonly = " 𝐑", unnamed = "⦿",
        modified = " " } } },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { { "filename", path = 1, icon = "⤷" } },
  },
})
