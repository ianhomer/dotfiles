vim.o.completeopt = "menuone,noselect"

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local termcodes = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local lspkind = require("lspkind")
local cmp = require("cmp")
cmp.setup {
    sources = {
        {name = "buffer"},
        {name = "nvim_lsp"},
        {name = "nvim_lua"}
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            return vim_item
        end
    },
    mapping = {
        ["<CR>"] = cmp.mapping.confirm(
            {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            }
        ),
        ["<Tab>"] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(termcodes("<C-n>"))
            elseif check_back_space() then
                vim.fn.feedkeys(termcodes("<Tab>"))
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(termcodes("<C-p>"))
            elseif check_back_space() then
                vim.fn.feedkeys(termcodes("<S-Tab>"))
            else
                fallback()
            end
        end
    }
}
