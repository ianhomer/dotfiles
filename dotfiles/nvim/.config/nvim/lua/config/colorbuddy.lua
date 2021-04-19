local knobs = require("knobs")

if knobs.has("material") then
    vim.g.colors_name = "material"
    vim.api.nvim_set_keymap(
        "n",
        "<C-m>",
        [[<Cmd>lua require('material').toggle_style()<CR>]],
        {noremap = true, silent = true}
    )
    vim.api.nvim_set_keymap(
        "n",
        "<C-9>",
        [[<Cmd>lua require('material').change_style('lighter')<CR>]],
        {noremap = true, silent = true}
    )
    vim.api.nvim_set_keymap(
        "n",
        "<C-0>",
        [[<Cmd>lua require('material').change_style('oceanic')<CR>]],
        {noremap = true, silent = true}
    )
    require("material").change_style("deep ocean")
    require("colorbuddy").colorscheme("material")
else
    require("colorbuddy").colorscheme("gruvbuddy")
end
