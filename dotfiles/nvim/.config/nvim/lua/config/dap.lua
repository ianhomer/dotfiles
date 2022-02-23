local dap = require("dap")

function pick_node_debug_process()
    local output = vim.fn.system({ "ps", "a" })
    local lines = vim.split(output, "\n")
    local procs = {}
    for _, line in pairs(lines) do
        -- output format
        --    " 107021 pts/4    Ss     0:00 /bin/zsh <args>"
        local parts = vim.fn.split(vim.fn.trim(line), " \\+")
        local pid = parts[1]
        local name = table.concat({ unpack(parts, 5) }, " ")
        if pid and pid ~= "PID" then
            pid = tonumber(pid)
            if pid ~= vim.fn.getpid() and string.match(name, "node.*--inspect") then
                table.insert(procs, { pid = pid, name = name })
            end
        end
    end
    local result = pick_one(procs)
    return result and result.pid or nil
end

function pick_one(procs)
    if table.getn(procs) == 1 then
        return table[0]
    end
    local label_fn = function(proc)
        return string.format("id=%d name=%s", proc.pid, proc.name)
    end
    return require("dap.ui").pick_one_sync(procs, "Select process", label_fn)
end

dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/projects/opensource/vscode-node-debug2/out/src/nodeDebug.js" },
}
dap.configurations.javascript = {
    {
        name = "Attach to process",
        type = "node2",
        request = "attach",
        processId = pick_node_debug_process,
    },
}
dap.configurations.typescript = dap.configurations.javascript

