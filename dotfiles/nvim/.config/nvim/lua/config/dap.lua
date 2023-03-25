require("dap-vscode-js").setup({
  debugger_path = os.getenv("HOME") .. "/projects/opensource/vscode-js-debug",
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal",
    "pwa-extensionHost" },
})

-- local dap = require("dap")
-- local myutils = require("myutils")

-- local function pick_node_debug_process()
--   local processOnPort = myutils.find_process_on_port(9229)
--   if processOnPort then
--     return processOnPort
--   end
--   local procs = myutils.find_named_processes("node")
--   if table.getn(procs) == 1 then
--     return procs[0].pid
--   end
--   local label_fn = function(proc)
--     return string.format("id=%d name=%s", proc.pid, proc.name)
--   end
--   return require("dap.ui").pick_one_sync(procs, "Select process", label_fn)
-- end

-- dap.adapters.node2 = {
--   type = "executable",
--   command = "node",
--   args = {
--     os.getenv("HOME") ..
--     "/projects/opensource/vscode-node-debug2/out/src/nodeDebug.js",
--   },
-- }
-- dap.configurations.javascript = {
--   {
--     name = "Attach to process",
--     type = "node2",
--     request = "attach",
--     processId = pick_node_debug_process,
--   },
-- }
-- dap.configurations.typescript = dap.configurations.javascript

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require("dap.utils").pick_process,
      skipFiles = { "<node_internals>/**" },
      cwd = vim.fn.getcwd(),
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
  }
end

-- log in lua print(vim.fn.stdpath('cache')) dap.log
-- require("dap").set_log_level("TRACE")
