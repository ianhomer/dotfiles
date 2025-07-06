return {
  "cenk1cenk2/schema-companion.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
  },
  config = function()
    require("schema-companion").setup({
      -- if you have telescope you can register the extension
      enable_telescope = true,
      matchers = {
        -- add your matchers
        require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
      },
    })
  end,
}
