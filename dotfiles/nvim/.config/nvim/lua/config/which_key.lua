local wk = require("which-key")
local knobs = require("knobs")

wk.setup {}

local map = {}
if knobs.has("telescope") then
    map["f"] = {"<cmd>Telescope find_files hidden=true<cr>", "Find File"}
    map["S"] = {"<cmd>Telescope live_grep hidden=true<cr>", "Search"}
end

if knobs.has("toggleterm") then
    map["a"] = {"<cmd>ToggleTerm<cr>", "Terminal"}
end

if knobs.has("nvim_tree") then
    map["n"] = {"<cmd>NvimTreeFindFile<cr>", "Files"}
end

wk.register(map, {prefix = "<leader>"})
