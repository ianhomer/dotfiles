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
    completion = {
        completeopt = "menu,menuone,noinsert"
    },
    experimental = {
        native_menu = true,
        ghost_text = true
    },
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
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<Down>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
        ["<Up>"] = cmp.mapping.select_prev_item(
            {
                behavior = cmp.SelectBehavior.Select
            }
        ),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<Right>"] = cmp.mapping.confirm(
            {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            }
        ),
        ["<CR>"] = cmp.mapping.confirm(
            {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            }
        ),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif check_back_space() then
                vim.fn.feedkeys(termcodes("<Tab>"), "n")
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif check_back_space() then
                vim.fn.feedkeys(termcodes("<S-Tab>"), "n")
            else
                fallback()
            end
        end
    }
}
