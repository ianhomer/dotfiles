local actions = require("telescope.actions")
local navigator = require("config.navigator")

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

local rg_ignore = os.getenv("HOME") .. "/.config/rg/nvim-telescope.ignore"
local rg_ignore_lesser = os.getenv("HOME") .. "/.config/rg/nvim-telescope-lesser.ignore"

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
      rg_ignore,
      "--ignore-file",
      rg_ignore_lesser,
    },
    prompt_prefix = "   ",
    entry_prefix = "  ",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-left>"] = function()
          navigator.navigate("h")
        end,
        ["<c-right>"] = function()
          navigator.navigate("l")
        end,
        ["<c-up>"] = function()
          navigator.navigate("k")
        end,
        ["<c-down>"] = function()
          navigator.navigate("j")
        end,
      },
    },
    --    i = {["<c-t>"] = trouble.open_with_trouble},
    --    n = {["<c-t>"] = trouble.open_with_trouble}
    --},
    path_display = {
      shorten = { len = 3, exclude = { 1, -1, -2 } },
    },
    layout_strategy = "vertical",
    layout_config = {
      horizontal = {
        prompt_position = "bottom",
      },
      vertical = {
        mirror = false,
      },
      height = 0.99,
      width = 0.99,
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
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--glob",
        "!**/.git/**",
        "--ignore-file",
        rg_ignore,
        "--ignore-file",
        rg_ignore_lesser,
      },
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

local opts = { noremap = true, silent = true }

-- Register gitmoji symbols from telescope-symbols plugin
vim.keymap.set("i", "<C-l>", "<cmd>lua require'telescope.builtin'.symbols{ sources = {'gitmoji'}}<cr>", opts)
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
