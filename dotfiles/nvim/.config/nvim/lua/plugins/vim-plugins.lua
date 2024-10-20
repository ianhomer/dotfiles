return {
  { "tpope/vim-eunuch" },
  {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
      { "<leader>gg", "<cmd>Git<cr>", desc = "Fugitive" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
    },
  },
}
