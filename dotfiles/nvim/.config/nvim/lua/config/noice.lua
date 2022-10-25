require("noice").setup({
    views = {
        cmdline_popup = {
            position = {
                row = "90%",
                col = "2",
            },
            border = {
                style = "none",
                padding = { 2, 3 },
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
