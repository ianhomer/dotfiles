local M = {}

M.config = function()
  require("trouble").setup({
    auto_open = false,
    auto_close = true,
    auto_jump = true,
    height = 15,
    use_diagnostic_signs = true,
    padding = false,
    warn_no_results = false,
  })
end

M.keys = {
  {
    "[q",
    function()
      local trouble = require("trouble")
      if trouble.is_open() then
        trouble.previous({ skip_groups = true, jump = true })
      else
        vim.cmd.cprev()
      end
    end,
    desc = "Previous trouble/quickfix item",
  },
  {
    "]q",
    function()
      local trouble = require("trouble")
      if trouble.is_open() then
        trouble.next({ skip_groups = true, jump = true })
      else
        vim.cmd.cnext()
      end
    end,
    desc = "Next trouble/quickfix item",
  },
}

return M
