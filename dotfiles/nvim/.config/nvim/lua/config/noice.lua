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
    messages = {
        enabled = true,
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
