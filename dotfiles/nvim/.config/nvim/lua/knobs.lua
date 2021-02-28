local M = {}

local g = vim.g

function M.has(name)
  return (g["knob_" .. name] or 0) > 0
end

return M
