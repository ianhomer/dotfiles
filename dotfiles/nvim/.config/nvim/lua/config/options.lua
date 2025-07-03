-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.root_spec = { "cwd" }
vim.g.autoformat = true
vim.o.winborder = "bold"
-- vim.g.lazyvim_picker = "telescope"

local opt = vim.opt
opt.relativenumber = false
opt.conceallevel = 0

-- Shift + J/K moves selected lines down/up in visual mode
local cmd = vim.cmd
cmd([[
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv
vnoremap <silent> <S-Up> :m '<-2<CR>gv=gv
vnoremap <silent> <S-Down> :m '>+1<CR>gv=gv
nnoremap <silent> <S-Up> :m-2<CR>
nnoremap <silent> <S-Down> :m+<CR>
inoremap <silent> <S-Up> <Esc>:m-2<CR>
inoremap <silent> <S-Down> <Esc>:m+<CR>
  ]])

vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopeFindPre",
  callback = function()
    vim.opt_local.winborder = "none"
    vim.api.nvim_create_autocmd("WinLeave", {
      once = true,
      callback = function()
        vim.opt_local.winborder = "rounded"
      end,
    })
  end,
})
