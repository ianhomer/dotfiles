return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      menu = {
        auto_show = false,
      },
    },
    keymap = {
      preset = "super-tab",
      --  work around until https://github.com/LazyVim/LazyVim/pull/6183 lands
      ["<Tab>"] = {
        require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
        LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
        "fallback",
      },
    },
  },
}
