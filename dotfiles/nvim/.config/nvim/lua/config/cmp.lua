vim.o.completeopt = "menu,menuone,noselect"

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      if vim.g.knob_luasnip then
        require("luasnip").lsp_expand(args.body)
      else
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#no-snippet-plugin
        unpack = unpack or table.unpack
        local line_num, col = unpack(vim.api.nvim_win_get_cursor(0))
        local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
        local indent = string.match(line_text, "^%s*")
        local replace = vim.split(args.body, "\n", true)
        local surround = string.match(line_text, "%S.*") or ""
        local surround_end = surround:sub(col)

        replace[1] = surround:sub(0, col - 1) .. replace[1]
        replace[#replace] = replace[#replace] .. (#surround_end > 1 and " " or "") .. surround_end
        if indent ~= "" then
          for i, line in ipairs(replace) do
            replace[i] = indent .. line
          end
        end

        vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, replace)
      end
    end,
  },
  -- customise enabled for completion in DAP REPL
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
      or (vim.g["knob_dap"] and require("cmp_dap").is_dap_buffer())
  end,
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Right>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<CR>"] = cmp.mapping.confirm({
      select = false,
    }),
    ["<S-CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.g.knob_luasnip and require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      elseif check_back_space() then
        vim.fn.feedkeys(termcodes("<Tab>"), "n")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.g.knob_luasnip and require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      elseif check_back_space() then
        vim.fn.feedkeys(termcodes("<S-Tab>"), "n")
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  experimental = {
    ghost_text = {
      hl_group = "LspCodeLens",
    },
  },
  sources = {
    { name = "nvim_lsp", max_item_count = 10 },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "nvim_lsp_signature_help" },
  },
  formatting = {
    format = require("lspkind").cmp_format({
      mode = "symbol_text",
      before = function(entry, vim_item)
        if entry.source.name == "nvim_lsp" then
          vim_item.dup = 0
        end
        return vim_item
      end,
    }),
    --format = lspkind.cmp_format({ mode = "symbol" }),
  },
  matching = {
    disallow_fuzzy_matching = true,
    disallow_partial_matching = true,
  },
  view = {
    entries = "custom",
  },
})

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "buffer" },
  }),
})

if vim.g.knob_dap then
  cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
      { name = "dap" },
    },
  })
end

for _, v in pairs({ "/", "?" }) do
  cmp.setup.cmdline(v, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
end

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- require("luasnip.loaders.from_vscode").lazy_load()
