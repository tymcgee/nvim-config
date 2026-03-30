local gh = Config.gh
vim.pack.add({
    gh("nvim-treesitter/nvim-treesitter-context"),
    gh("folke/ts-comments.nvim"),
    gh("andymass/vim-matchup"),
    gh("windwp/nvim-ts-autotag"),
    { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
})
require("nvim-ts-autotag").setup({ opts = { enable_close_on_slash = true } })
require("ts-comments").setup()

local ts_update = function() vim.cmd("TSUpdate") end
Config.on_packchanged("nvim-treesitter", { "update" }, ts_update, ":TSUpdate")

local ts = require("nvim-treesitter")
local parsers = {
    "json",
    "yaml",
    "toml",
    "csv",
    "xml",
    "python",
    "lua",
    "luadoc",
    "rust",
    "bash",
    "javascript",
    "markdown",
    "markdown_inline",
    "regex",
    "typescript",
    "tsx",
    "gitcommit",
    "gitignore",
    "git_config",
    "sql",
    "css",
    "scss",
    "html",
    "htmldjango",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "http",
    "svelte",
    "templ",
    "vimdoc",
    "fish",
    "c",
    "cpp",
    "make",
    "ssh_config",
    "caddy",
    "java",
    "javadoc",
    "terraform",
}

-- this is a no-op for parsers that are already installed
ts.install(parsers)
local installed_filetypes = ts.get_installed()

local start = function()
    vim.treesitter.start()
    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end
Config.new_autocmd("FileType", installed_filetypes, start, "Enable treesitter")
