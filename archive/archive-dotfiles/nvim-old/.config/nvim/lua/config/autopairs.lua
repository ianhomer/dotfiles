if vim.g.knob_cmp then
  local autopairs = require("nvim-autopairs")
  autopairs.setup({})
  autopairs.remove_rule("`")
  autopairs.remove_rule("```")
end
