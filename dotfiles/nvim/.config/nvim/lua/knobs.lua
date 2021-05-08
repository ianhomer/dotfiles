local M = {}
local KNOB_VIM_RE = "^[%w-]+/n?vim%-([%w-]+)"
local KNOB_VIM_AFTER_RE = "^[%w-]+/([%w-]+)-n?vim"
local KNOB_RE = "^[%w-]+/([%w-]+)"
local REPO_RE = "^[%w-]+/([%w-_.]+)$"
local cmd = vim.api.nvim_command

cmd "call knobs#Init()"

function M.has(knob)
    return (vim.g["knob_" .. knob] or 0) > 0
end

function knobFromPackage(package)
    return (package:match(KNOB_VIM_RE) or package:match(KNOB_VIM_AFTER_RE) or package:match(KNOB_RE)):gsub("-", "_")
end

function M.useif(use, disableIf)
    local disableIf = disableIf ~= nil
    return function(args)
        if type(args) == "string" then
            args = {args}
        end
        local package = args[1]
        knob = knobFromPackage(package)
        local knobVariable = "knob_" .. knob
        if vim.g["knobs_levels"][knob] ~= nil then
            -- print(package .. ":" .. knob .. ":" .. tostring(vim.g[knobVariable]))
            if disableIf then
               args.disable = (vim.g[knobVariable] or 0) == 0
            else
               args.cond = 'vim.g["' .. knobVariable .. '"]'
            end
        else
            -- print(package .. ":" .. knob .. " does not exist")
        end
        use(args)
    end
end

return M
