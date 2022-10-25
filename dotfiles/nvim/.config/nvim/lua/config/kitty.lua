local M = {}

local kitty_direction = {
    h = "left",
    l = "right",
    j = "bottom",
    k = "top"
}

local function kitty(command)
   os.execute("kitty @ "..command)
end

local function navigate(direction)
    local current_window = vim.fn.win_getid()
    vim.api.nvim_command('wincmd ' .. direction)
    local at_edge = current_window == vim.fn.win_getid()
    if (at_edge) then
        kitty("kitten navigate.py "..kitty_direction[direction])
    end
end


vim.keymap.set("", "<c-h>", function()
    navigate("h")
end)
vim.keymap.set("", "<c-l>", function()
    navigate("l")
end)
vim.keymap.set("", "<c-k>", function()
    navigate("k")
end)
vim.keymap.set("", "<c-j>", function()
    navigate("j")
end)

return M

