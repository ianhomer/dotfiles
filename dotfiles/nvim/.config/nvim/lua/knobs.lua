local M = {}
local KNOB_VIM_RE = '^[%w-]+/vim%-([%w]+)'
local KNOB_RE = '^[%w-]+/([%w]+)'
local REPO_RE = '^[%w-]+/([%w-_.]+)$'
local cmd = vim.api.nvim_command

function M.has(knob)
  return (vim.g["knob_".. knob] or 0) > 0
end

function knobFromPackage(package)
  return package:match(KNOB_VIM_RE) or package:match(KNOB_RE)
end

function M.useif(use)
  return function(args)
    knob = knobFromPackage(args[1])
    args.cond = function(args)
      return (vim.g["knob_".. knob] or 0) > 0
    end
    use(args)
  end
end

return M
