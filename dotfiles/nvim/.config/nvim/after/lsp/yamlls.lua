-- Not sure why, but this plugin is not loading, if I ever work out how to get
-- it loading I can clean this up
-- print("after/lsp/yamlls called, duplicated logic in lua/config/lazy.lua can be removed ")

return require("schema-companion").setup_client(require("schema-companion").adapters.yamlls.setup({
  enable_telescope = true,
  sources = {
    require("schema-companion").sources.matchers.kubernetes.setup({ version = "master" }),
    require("schema-companion").sources.lsp.setup(),
    require("schema-companion").sources.schemas.setup({
      {
        name = "Kubernetes master",
        uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
      },
    }),
  },
}))
