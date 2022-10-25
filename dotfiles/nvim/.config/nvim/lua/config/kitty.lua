local M = {}

local directions = {
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
        kitty("kitten navigate.py "..directions[direction])
    end
end

for key,_ in pairs(directions) do
    vim.keymap.set("", "<c-".. key.. ">", function()
        navigate(key)
    end)
end

return M

