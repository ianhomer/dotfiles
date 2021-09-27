vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_ignore = {".DS_Store", ".git", ".pytest_cache", "node_modules"}

vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 0
}

vim.g.nvim_tree_icons = {
    default = ""
}

vim.cmd [[highlight NvimTreeFolderIcon guifg=#928374]]
vim.cmd [[highlight NvimTreeFolderName guifg=#8ec07c]]

require'nvim-tree'.setup{
  lsp_diagnostics = 1
}
