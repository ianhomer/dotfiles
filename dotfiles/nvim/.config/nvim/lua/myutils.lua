local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

function M.find_process_on_port(port)
    local pid = vim.trim(vim.fn.system({ "lsof", "-i", ":" .. port, "-t" }))
    if pid == "" then
        return nil
    else
        return pid
    end
end

function M.find_named_processes(match)
    local lines = vim.fn.systemlist({ "ps", "a" })
    local procs = {}
    for _, line in pairs(lines) do
        local parts = vim.fn.split(vim.fn.trim(line), " \\+")
        local pid = parts[1]
        local name = table.concat({ unpack(parts, 5) }, " ")
        if pid and pid ~= "PID" then
            pid = tonumber(pid)
            if string.match(name, match) then
                table.insert(procs, { pid = pid, name = name })
            end
        end
    end
    return procs
end

function M.find_node_process()
    local processOnPort = M.find_process_on_port(9220)
    if processOnPort then
        return processOnPort
    end
    local processesMatchingNode = M.find_named_processes("node")
    if table.getn(processesMatchingNode) == 1  then
        return processesMatchingNode[0].pid
    end
    return processesMatchingNode
end

return M
