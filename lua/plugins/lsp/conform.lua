-- for a list of formatters:
-- :help conform-formatters
return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "black" },
            json = { "fixjson", "jq" },
            yaml = { "yamlfix", "yamlformat" },
            sh = { "shfmt" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    },
}
