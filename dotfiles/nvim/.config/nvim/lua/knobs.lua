local M = {}
local REPO_RE = '^[%w-]+/([%w-_.]+)$'
local cmd = vim.api.nvim_command

local g = vim.g
local paq = require('paq-nvim').paq  -- a convenient alias

function M.has(knob)
  return (g["knob_".. knob] or 0) > 0
end

function M.paq(knob, package)
  if M.has(knob) then
    paq({package, opt=true})
    name = package:match(REPO_RE)
    cmd('packadd ' .. name)
  end
end

return M
