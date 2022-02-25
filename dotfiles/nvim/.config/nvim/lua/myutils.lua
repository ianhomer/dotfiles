local M = {}

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

function M.find_process_on_port(port)
    local pid = vim.trim(vim.fn.system({ "lsof", "-i", ":" .. port, "-t" }))
    if pid == "" then return nil else return pid end
end

local pick_process = function(opts)
  opts = opts or {}
  local timer = vim.loop.new_timer()
  local picker = pickers.new(opts, {
    prompt_title = "process",
    finder = finders.new_table {
      results = opts.procs,
      entry_maker = function(entry)
          return {
            value = entry,
            display = entry.name,
            ordinal = entry.name,
          }
      end,
    },
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()
        return selection.value.pid
      end)
      return 123
    end,
    sorter = conf.generic_sorter(opts),
  })
  picker:find()
  timer:start(1000, function()
  end)
  return picker:get_selection()
  -- :find()
  -- return 1234
  -- return picker:get_selection()
end

function M.find_named_process(match)
    local lines = vim.fn.systemlist({ "ps", "a"})
    local procs = {}
    for _, line in pairs(lines) do
        local parts = vim.fn.split(vim.fn.trim(line), " \\+")
        local pid = parts[1]
        local name = table.concat({ unpack(parts, 5) }, " ")
        if pid and pid ~= "PID" then
            pid = tonumber(pid)
            if pid ~= vim.fn.getpid() and string.match(name, match) then
                table.insert(procs, { pid = pid, name = name })
            end
        end
    end
    if table.getn(procs) == 1 then
        return table[0].pid
    end
    return pick_process({procs = procs})
end

function M.pick_node_debug_process()
    return M.find_process_on_port(9220) or M.find_named_process("node") or 1
end

return M
