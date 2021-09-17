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
        {name = "nvim_lsp"},
        {name = "buffer"},
        {name = "vsnip"},
        {name = "nvim_lua"},
        {name = "path"}
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            return vim_item
        end
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end
    },
    mapping = {
        ["<CR>"] = cmp.mapping.confirm(
            {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false
            }
        ),
        ["<Tab>"] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(termcodes("<C-n>"),'n')
            elseif check_back_space() then
                vim.fn.feedkeys(termcodes("<Tab>"), 'n')
            elseif vim.fn["vsnip#available"]() == 1 then
                vim.fn.feedkeys(termcodes("<Plug>(vsnip-expand-or-jump)"), '')
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(termcodes("<C-p>"), 'n')
            elseif check_back_space() then
                vim.fn.feedkeys(termcodes("<S-Tab>"), 'n')
            else
                fallback()
            end
        end
    }
}
