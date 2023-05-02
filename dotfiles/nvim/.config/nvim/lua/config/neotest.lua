require("neotest").setup({
  adapters = {
    -- require("neotest-python")({
    --   dap = { justMyCode = false },
    -- }),
    -- require("neotest-plenary"),
    require("neotest-vim-test")({
      allow_file_types = { "javascript" },
    }),
  },
})
