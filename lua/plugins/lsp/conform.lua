return {
    {
        -- for a list of formatters:
        -- :help conform-formatters
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                -- sub-list means "use the first one you find"
                -- list means "use one after the other"
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "black" },
                    go = { "goimports", "gofumpt" },
                    templ = { "templ" },
                    json = { { "fixjson", "jq", "prettierd" } },
                    yaml = { "yamlfix" },
                    sh = { "shfmt" },
                    css = { "prettierd" },
                    scss = { "prettierd" },
                    html = { "prettier" },
                    javascript = { "prettierd" },
                    typescript = { "prettierd" },
                    svelte = { "prettierd" },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                    async = true,
                },
                notify_on_error = false,
                formatters = {
                    prettier = {
                        prepend_args = { "--tab-width", "4" },
                    },
                },
            })
        end,
    },
    {
        "laytan/tailwind-sorter.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
        build = "cd formatter && npm i && npm run build",
        opts = {
            on_save_enabled = true,
        },
    },
}
