-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.root_spec = { "cwd" }
vim.g.autoformat = false

local opt = vim.opt
opt.relativenumber = false
opt.conceallevel = 0
opt.spellfile = vim.fn.expand("$HOME/.config/vim/spell/en.utf-8.add")
