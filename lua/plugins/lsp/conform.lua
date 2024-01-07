-- for a list of formatters:
-- :help conform-formatters
return {
    "stevearc/conform.nvim",
    opts = {
        -- sub-list means "use the first one you find"
        -- list means "use one after the other"
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "black" },
            go = { "gofumpt" },
            json = { { "fixjson", "jq", "prettierd" } },
            yaml = { "yamlfix" },
            sh = { "shfmt" },
            css = { "prettierd" },
            scss = { "prettierd" },
            html = { "prettierd", "djlint" },
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
    },
}
