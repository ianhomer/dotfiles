local M = {}

local g = vim.g
local paq = require('paq-nvim').paq  -- a convenient alias

function M.has(knob)
  return (g["knob_" .. knob] or 0) > 0
end

function M.paq(knob, package)
  if M.has(knob) then
    paq({package, opt=false})
  end
end

return M
