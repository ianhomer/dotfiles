local M = {}
local REPO_RE = '^[%w-]+/([%w-_.]+)$'
local cmd = vim.api.nvim_command

local g = vim.g
local paq = require('paq-nvim').paq  -- a convenient alias

function M.has(knob)
  return (g["knob_".. knob] or 0) > 0
end

function M.paq(args)
  local package = args[1] or args.package
  local knob = args[2] or args.knob
  local opt = args[3] or args.opt or true

  if M.has(knob) then
    paq({package, opt=opt})
    name = package:match(REPO_RE)
    cmd('packadd ' .. name)
  end
end

function M.paq1(knob, package)
  if M.has(knob) then
    paq({package, opt=true})
    name = package:match(REPO_RE)
    cmd('packadd ' .. name)
  end
end

return M
