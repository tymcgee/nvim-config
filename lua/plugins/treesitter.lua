return {
    {
        { "nvim-treesitter/nvim-treesitter-context", config = true },

        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            config = function()
                return require("ts_context_commentstring").setup({
                    enable_autocmd = false,
                })
            end,
        },

        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                    highlight = {
                        enable = true,
                    },
                    indent = {
                        enable = true,
                        disable = { "python" },
                    },
                    ensure_installed = {
                        "json",
                        "yaml",
                        "toml",
                        "csv",
                        "xml",
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
                        "gitignore",
                        "git_config",
                        "sql",
                        "css",
                        "scss",
                        "html",
                        "go",
                        "gomod",
                        "http",
                        "svelte",
                        "templ",
                        "vimdoc",
                        "fish",
                        "c",
                        "cpp",
                        "make",
                        "ssh_config",
                    },
                })
            end,
        },
    },
}
