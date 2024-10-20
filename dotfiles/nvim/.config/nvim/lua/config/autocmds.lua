-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- By default LazyVim uses conform with LSP fallback for formatting. For
-- markdown this ends up using prettier for formatting. For my install this
-- wasn't formatting long lines when I used {motion}gq or gqq. The default vim
-- behaviour has always been pretty good for me, so rather than explore the
-- complexities of the conform plugin, for Markdown I just use the default vim
-- behaviour.

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("markdown_format"),
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.textwidth = 80
    -- j remove comment leader on join
    -- (disabled) t auto wrap using textwidth
    -- c auto wrap comments
    -- q allow formatting with gq
    -- l don't break long lines (once they'r long)
    vim.opt_local.formatoptions = "jcqln"
    vim.opt_local.formatexpr = ""

    -- Use project local spellfile if it exists
    local dot_git_path = vim.fn.finddir(".git", ".;")
    if vim.fn.isdirectory(dot_git_path) ~= 0 then
      local project_spelling_file = vim.fn.fnamemodify(dot_git_path, ":h") .. "/.vim/local.utf-8.add"
      if vim.fn.filereadable(project_spelling_file) ~= 0 then
        local spelling_files = project_spelling_file
        vim.opt_local.spellfile = spelling_files
      end
    end
  end,
})
