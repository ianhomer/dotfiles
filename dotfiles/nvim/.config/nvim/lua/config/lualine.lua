local function repositoryName()
  local filename = vim.fn.expand '%:p'
  local _,j = string.find(filename, "projects/things/")
  if j > 0 then
    local k,_ = string.find(filename, "/", j + 1)
    if k > 0 then
      return filename.sub(filename, j+1, k-1)
    end
  end
  return nil
end

require("lualine").setup {
    -- options = {
    --     theme = "kanagawa"
    -- },
    extensions = {
        "fugitive",
        "fzf",
        "nvim-tree",
        "toggleterm"
    },
    sections = {
        lualine_c = {
            {repositoryName,
              color = {fg=225, gui='bold'}
            },
            {"filename"},
            {"diff"},
            {
                "diagnostics",
                sources = {"ale", "nvim_diagnostic"},
                diagnostics_color = {
                  error = "white"
                }
            }
        },
        lualine_x = {'filetype'}
    }
}
