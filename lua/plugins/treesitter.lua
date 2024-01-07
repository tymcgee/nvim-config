return {
    {
        { "nvim-treesitter/nvim-treesitter-context", config = true },

        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- not sure why i have to specify all of these even though they're mentioned as defaults...
                -- but it wasn't working in svelte files unless i did
                autotag = {
                    enable = true,
                    enable_rename = true,
                    enable_close = true,
                    enable_close_on_slash = true,
                    filetypes = { "html", "xml", "svelte", "markdown", "javascript", "typescript" },
                },
                highlight = {
                    enable = true,
                    -- custom_captures = {
                    -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
                    -- ["foo.bar"] = "Identifier",
                    -- },
                },
                indent = {
                    enable = true,
                    disable = { "python" },
                },
                ensure_installed = {
                    "json",
                    "yaml",
                    "python",
                    "lua",
                    "rust",
                    "bash",
                    "javascript",
                    "markdown",
                    "markdown_inline",
                    "regex",
                    "typescript",
                    "tsx",
                    "gitcommit",
                    "toml",
                    "sql",
                    "css",
                    "scss",
                    "go",
                    "http",
                    "svelte",
                    "templ",
                },
            })
        end,
    },
}
