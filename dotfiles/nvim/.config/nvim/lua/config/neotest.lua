require("neotest").setup({
    adapters = {
        -- require("neotest-jest")({
        --     jestCommand = "npm test --",
        --     jestConfigFile = "custom.jest.config.ts",
        -- }),
        require("neotest-vim-test")()
    },
})
