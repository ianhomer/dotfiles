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

require("lualine").setup({
    options = {
        -- => localstatus = 3
        globalstatus = true,
    },
    -- options = {
    --     theme = "kanagawa"
    -- },
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
            }
        },
        lualine_x = { { "filetype", icon_only = true } },
        lualine_y = { "progress" },
        lualine_z = { "location", { "filename", symbols = { readonly = " 𝐑", unnamed = "⦿", modified = " " } } },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
})
