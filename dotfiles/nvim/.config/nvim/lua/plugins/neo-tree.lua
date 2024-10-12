return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      bind_to_cwd = true,
      filtered_items = {
        visible = true,
        never_show = {
          ".git",
          ".DS_Store",
        },
      },
    },
  },
}
