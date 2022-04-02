---@diagnostic disable: undefined-field
local dap = require("dap")
local myutils = require("myutils")

local function pick_node_debug_process()
    local processOnPort = myutils.find_process_on_port(9229)
    if processOnPort then
        return processOnPort
    end
    local procs = myutils.find_named_processes("node")
    if table.getn(procs) == 1  then
        return procs[0].pid
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
