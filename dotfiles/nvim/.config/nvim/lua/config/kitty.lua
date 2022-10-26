local M = {}

local directions = {
    h = "left",
    l = "right",
    j = "bottom",
    k = "top"
}

local function command(command)
   os.execute("kitty @ "..command)
end

function M.navigate(direction)
  command("kitten navigate.py "..directions[direction])
end

function M.go_direction(direction)
    local current_window = vim.fn.win_getid()
    vim.api.nvim_command('wincmd ' .. direction)
    local at_edge = current_window == vim.fn.win_getid()
     if (at_edge) then
        M.navigate(direction)
    end
end

for key,_ in pairs(directions) do
    vim.keymap.set("", "<c-".. key.. ">", function()
        M.go_direction(key)
    end)
end

return M

