local function repositoryName()
    local filename = vim.fn.expand("%:p")
    local _, j = string.find(filename, "projects/things/")
    if j > 0 then
        local k, _ = string.find(filename, "/", j + 1)
        if k > 0 then
            return filename.sub(filename, j + 1, k - 1)
        end
    end
    return nil
end

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local has_kanagawa, kanagawa = pcall(require,"lualine.themes.kanagawa")
if has_kanagawa then
  kanagawa.inactive.a.bg = kanagawa.normal.b.bg
  kanagawa.inactive.b.bg = kanagawa.normal.b.bg
  kanagawa.inactive.c.bg = kanagawa.normal.b.bg
end

require("lualine").setup({
    options = {
        -- => localstatus = 3
        globalstatus = true,
        theme = kanagawa,
    },
    extensions = {
        "fugitive",
        "fzf",
        "mundo",
        "nvim-dap-ui",
        "nvim-tree",
        "toggleterm",
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
            { repositoryName, color = { fg = 225, gui = "bold" } },
            { "diff", source = diff_source },
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                diagnostics_color = {
                    error = "white",
                },
            },
        },
        lualine_x = { { "filetype", icon_only = true } },
        lualine_y = { "progress" },
        lualine_z = { "location", { "filename", symbols = { readonly = " 𝐑", unnamed = "⦿", modified = " " } } },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { { "filename", path = 1, icon = "⤷" } },
    },
})
