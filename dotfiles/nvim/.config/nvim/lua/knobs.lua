local M = {}
local KNOB_VIM_RE = "^[%w-]+/n?vim%-([%w-]+)"
local KNOB_VIM_AFTER_RE = "^[%w-]+/([%w-]+)-n?vim"
local KNOB_RE = "^[%w-]+/([%w-]+)"
local REPO_RE = "^[%w-]+/([%w-_.]+)$"
local PLUGIN_RE = "^[^/]*/(.*)$"
local cmd = vim.api.nvim_command

cmd "call knobs#Init()"

function M.has(knob)
    return (vim.g["knob_" .. knob] or 0) > 0
end

function knobFromPackage(package)
    return (package:match(KNOB_VIM_RE) or package:match(KNOB_VIM_AFTER_RE) or package:match(KNOB_RE)):gsub("-", "_"):lower(

    )
end

function pluginFromPackage(package)
  return package:match(PLUGIN_RE)
end

function M.use(use, disableIf, timer)
    local disableIf = disableIf ~= nil
    local timer = timer ~= nil
    return function(args)
        if type(args) == "string" then
            args = {args}
        end
        local package = args[1]
        if args.defer then
          -- handle defering of a knob by executing plugin load in deferred
          -- function in set up
          args.opt = true
          args.setup = 'require "knobs".defer("'..package..'",'..tostring(args.defer)..')'
        else
          knob = knobFromPackage(package)
          local knobVariable = "knob_" .. knob
          if vim.g["knobs_levels"][knob] ~= nil then
              if M.has("debug") then
                  print(package .. ":" .. knob .. ":" .. tostring(vim.g[knobVariable]))
              end
              if disableIf then
                  args.disable = (vim.g[knobVariable] or 0) == 0
              else
                  args.cond = 'vim.g["' .. knobVariable .. '"]'
              end
          else
              if M.has("debug") then
                  print(package .. ":" .. knob .. " does not exist")
              end
          end
        end
        use(args)
    end
end

-- defer the loading of a plugin
function M.defer(package, timer)
    timer = timer or 2000
    knob = knobFromPackage(package)
    if M.has(knob) then
      vim.defer_fn(
          function()
                local plugin = pluginFromPackage(package)
                require("packer").loader(plugin)
          end,
          timer
      )
    end
end

return M
