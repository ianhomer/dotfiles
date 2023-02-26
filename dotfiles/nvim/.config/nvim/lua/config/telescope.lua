local actions = require("telescope.actions")
local kitty = require("config.kitty")
-- local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

local git_command = {
  "git",
  "log",
  "--date=format:%Y-%m-%d %H:%M",
  "--format=%h %cd %<(8,trunc)%aN %s",
  "--abbrev-commit",
  "--",
  ".",
}

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
      "--hidden",
      "--ignore-file",
      os.getenv("HOME") .. "/.config/rg/nvim-telescope.ignore",
    },
    prompt_prefix = "   ",
    entry_prefix = "  ",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-left>"] = function()
          kitty.navigate("h")
        end,
        ["<c-right>"] = function()
          kitty.navigate("l")
        end,
        ["<c-up>"] = function()
          kitty.navigate("k")
        end,
        ["<c-down>"] = function()
          kitty.navigate("j")
        end,
      },
    },
    --    i = {["<c-t>"] = trouble.open_with_trouble},
    --    n = {["<c-t>"] = trouble.open_with_trouble}
    --},
    path_display = { "shorten" },
    layout_strategy = "vertical",
    layout_config = {
      horizontal = {
        prompt_position = "bottom",
      },
      vertical = {
        mirror = false,
      },
      height = 0.95,
      width = 0.95,
    },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  },
  extensions = {
    frecency = {
      default_workspace = "CWD",
      show_scores = true,
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ["<c-k>"] = "delete_buffer",
        },
      },
    },
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/**" },
    },
    git_bcommits = {
      git_command = git_command,
    },
    git_commits = {
      git_command = git_command,
    },
  },
})

if vim.g.knob_telescope_fzf_native then
  telescope.load_extension("fzf")
end

if vim.g.knob_frecency then
  telescope.load_extension("frecency")
end

if vim.g.knob_refactoring then
  telescope.load_extension("refactoring")
end

local has_colors, colors_module = pcall(require, "kanagawa.colors")
if has_colors then
  local colors = colors_module.setup()

  vim.api.nvim_set_hl(0, "TelescopeBorder",
    { bg = colors.bg_dim, fg = colors.bg_dim })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder",
    { bg = colors.bg_light1, fg = colors.bg_light1 })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal",
    { bg = colors.bg_light1, fg = colors.nu })
  vim.api.nvim_set_hl(0, "TelescopePromptPrefix",
    { bg = colors.bg_light1, fg = colors.nu })
  vim.api.nvim_set_hl(0, "TelescopePromptTitle",
    { bg = colors.bg_light1, fg = colors.co })

  vim.api.nvim_set_hl(0, "TelescopeSelection",
    { bg = colors.bg_light1, fg = colors.nu })
  vim.api.nvim_set_hl(0, "TelescopePreviewTitle",
    { bg = colors.bg_dim, fg = colors.co })
  vim.api.nvim_set_hl(0, "TelescopeResultsTitle",
    { bg = colors.bg_dim, fg = colors.co })
end

local opts = { noremap = true, silent = true }

vim.keymap.set("i", "<C-l>",
  "<cmd>lua require'telescope.builtin'.symbols{ sources = {'gitmoji'}}<cr>", opts)
vim.keymap.set("i", "<C-k><C-l>", "<cmd>Telescope symbols<cr>", opts)

-- Disable which-key registry help in TelescopePrompt so that C-R can be used to
-- insert from registry
-- https://github.com/nvim-telescope/telescope.nvim/issues/1047
vim.api.nvim_exec(
  [[
    augroup telescope
        autocmd!
        autocmd FileType TelescopePrompt inoremap <buffer> <silent> <C-r> <C-r>
    augroup END]],
  false
)
