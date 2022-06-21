-- disable some builtin vim plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

vim.api.nvim_exec(
    [[
command! -nargs=* Fuzzy Telescope grep_string search=<args>
]],
    true
)

-- Persistent undo file
vim.opt.undofile = true
-- Use HOME expansion instead of ~ - https://github.com/neovim/neovim/issues/15720
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undo"
vim.g.mundo_width = 60
vim.g.mundo_right = 1

vim.o.foldenable = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.foldcolumn = "auto:2"
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.foldtext = "substitute(foldtext(), '\\(.*\\) \\(\\d\\+\\) lines: \\(.*\\)', '\\3 (\\2 lines)', 'g')"

