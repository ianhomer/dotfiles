local g = vim.g

-- disable some builtin vim plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end

vim.api.nvim_exec([[
command! -nargs=* Fuzzy Telescope grep_string search=<args>
]], true)


-- Persistent undo file
vim.nvim_set_option_value("undofile", nil)
vim.nvim_set_option_value("undodir", "~/.vim/undo")
g.mundo_width = 60
g.mundo_right = 1

