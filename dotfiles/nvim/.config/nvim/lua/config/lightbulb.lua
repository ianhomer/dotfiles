vim.fn.sign_define('LightBulbSign', { text = "💡", texthl = ""})

vim.api.nvim_exec([[
  augroup lightbulb_highlight
    autocmd! * <buffer>
    autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
  augroup END
]], false)

