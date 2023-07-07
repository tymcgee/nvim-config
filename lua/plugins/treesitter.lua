return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
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
                "regex",
                "typescript",
                "tsx",
            },
        },
    },

    { "nvim-treesitter/nvim-treesitter-context", config = true },
}

