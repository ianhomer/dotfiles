vim.wo.foldcolumn = '0'
vim.wo.foldlevel = 99
vim.wo.foldenable = true

require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})
