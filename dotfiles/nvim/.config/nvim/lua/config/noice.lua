require("noice").setup({
    views = {
        cmdline_popup = {
            position = {
                row = "99%",
                col = "0",
            },
            border = {
                style = "none",
                padding = { 0, 1 },
            },
            filter_options = {},
            win_options = {
                winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            },
        },
    },
    cmdline = {
        enabled = true,
    },
    lsp_progress = {
        enabled = true,
    },
    messages = {
        -- enable when fix vertical scroll and redraw issue
        enabled = false,
        view = "mini",
        view_warn = "mini",
        view_error = "mini",
    },
    history = {
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {
            event = { "msg_show", "notify" },
            ["not"] = { kind = { "search_count" } },
        },
    },
})
