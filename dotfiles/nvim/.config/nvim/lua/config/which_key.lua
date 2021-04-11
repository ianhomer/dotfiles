local cmd = vim.api.nvim_command

local map = {
    f = "Find files",
    s = "Search"
}

vim.fn["which_key#register"]("<Space>", map)
