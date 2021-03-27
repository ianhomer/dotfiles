local M = {}
local KNOB_VIM_RE = '^[%w-]+/vim%-([%w]+)'
local KNOB_RE = '^[%w-]+/([%w]+)'
local REPO_RE = '^[%w-]+/([%w-_.]+)$'
local cmd = vim.api.nvim_command
local use

local g = vim.g

function M.has(knob)
  return (g["knob_".. knob] or 0) > 0
end

function knobFromPackage(package)
  return package:match(KNOB_VIM_RE) or package:match(KNOB_RE)
end

function isOpt(args)
  if args[3] == nil then
    if args.opt == nil then
      return true
    end
    return args.opt
  end
  return args[3]
end

function M.setUse(_use)
  use = _use
end

function M.paq(args)
  local package = args[1] or args.package
  local knob = args[2] or args.knob or knobFromPackage(package)
  local opt = isOpt(args)

  -- print(package .. ":" .. knob .. ":" .. tostring(opt))
  if M.has(knob) then
    paq({package, opt=opt})
    if opt then
      name = package:match(REPO_RE)
      xpcall(cmd, function(err) 
        print(err)
      end, 'packadd ' .. name)
    end
  end
end

function M.use(args)
  local package = args[1] or args.package
  local knob = args[2] or args.knob or knobFromPackage(package)
  local opt = isOpt(args)

  print(package .. ":" .. knob .. ":" .. tostring(M.has(knob)) .. ":" .. tostring(opt))
  if M.has(knob) then
    use {package, opt=opt}
    if opt then
      name = package:match(REPO_RE)
      xpcall(cmd, function(err) 
        print(err)
      end, 'packadd ' .. name)
    end
  end
end

return M
