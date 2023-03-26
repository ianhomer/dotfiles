require("dap-vscode-js").setup({
  debugger_path = os.getenv("HOME") .. "/projects/opensource/vscode-js-debug",
  adapters = { "pwa-node" },
})

local myutils = require("myutils")

-- Automatically find the debug process
local function pick_node_debug_process()
  local processOnPort = myutils.find_process_on_port(9229)
  if processOnPort then
    return processOnPort
  end
  local procs = myutils.find_named_processes("node")
  if table.getn(procs) == 1 then
    return procs[0].pid
  end
  local label_fn = function(proc)
    return string.format("id=%d name=%s", proc.pid, proc.name)
  end
  return require("dap.ui").pick_one_sync(procs, "Select process", label_fn)
end

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = pick_node_debug_process,
      skipFiles = { "<node_internals>/**" },
      cwd = vim.fn.getcwd(),
      continueOnAttach = true,
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
  }
end

-- log in lua print(vim.fn.stdpath('cache')) dap.log
-- require("dap").set_log_level("TRACE")
