local M = {}
local KNOB_VIM_RE = '^[%w-]+/n+vim%-([%w]+)'
local KNOB_RE = '^[%w-]+/([%w]+)'
local REPO_RE = '^[%w-]+/([%w-_.]+)$'
local cmd = vim.api.nvim_command

function M.has(knob)
  return (vim.g["knob_".. knob] or 0) > 0
end

function knobFromPackage(package)
  return package:match(KNOB_VIM_RE) or package:match(KNOB_RE) or "nil"
end

function M.useif(use)
  return function(args)
    local package = args[1]
    knob = knobFromPackage(package)
    has = function(knob)
      return (vim.g["knob_".. knob] or 0) > 0
    end
    -- print(package .. ":" .. knob .. ":" .. tostring(has(knob)))

    args.cond = function(args)
      -- print(knob .. ":" .. tostring(has(knob)))
      return has(knob)
    end
    use(args)
  end
end

return M
