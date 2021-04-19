local M = {}
local KNOB_VIM_RE = "^[%w-]+/n?vim%-([%w-]+)"
local KNOB_RE = "^[%w-]+/([%w-]+)"
local REPO_RE = "^[%w-]+/([%w-_.]+)$"
local cmd = vim.api.nvim_command

cmd "call knobs#Init()"

function M.has(knob)
    return (vim.g["knob_" .. knob] or 0) > 0
end

function knobFromPackage(package)
    return (package:match(KNOB_VIM_RE) or package:match(KNOB_RE)):gsub("-", "_")
end

function M.useif(use)
    return function(args)
        if type(args) == "string" then
            args = {args}
        end
        local package = args[1]
        knob = knobFromPackage(package)
        -- print(package .. ":" .. knob .. ":" .. tostring(vim.g["knob_" .. knob]))
        args.cond = 'vim.g["knob_' .. knob .. '"]'
        use(args)
    end
end

return M
