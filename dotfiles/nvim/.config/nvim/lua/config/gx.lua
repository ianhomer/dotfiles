require("gx").setup({
  open_browser_app = "open",
  open_browser_args = { "--background" },
  handlers = {
    plugin = true,
    github = true,
    brewfile = true,
    package_json = true,
    search = true,
  },
  handler_options = {
    search_engine = "google",
  },
})
