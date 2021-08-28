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
    return (package:match(KNOB_VIM_RE) or package:match(KNOB_VIM_AFTER_RE) or package:match(KNOB_RE)):gsub("-", "_"):lower(

    )
end

function M.use(use, disableIf, timer)
    local disableIf = disableIf ~= nil
    local timer = timer ~= nil
    return function(args)
        if type(args) == "string" then
            args = {args}
        end
        local package = args[1]
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
        use(args)
    end
end

function M.defer(plugin, timer)
    timer = timer or 2000
    vim.defer_fn(
        function()
            print("Loading " .. plugin)
            require("packer").loader(plugin)
        end,
        timer
    )
end

return M
