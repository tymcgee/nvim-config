return {
    {
        -- for a list of formatters :help conform-formatters
        "stevearc/conform.nvim",
        lazy = true,
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_format" },
                    htmldjango = { "djlint" },
                    templ = { "templ" },
                    json = { "fixjson", "jq", "prettier", stop_after_first = true },
                    yaml = { "yamlfmt" },
                    sh = { "shfmt" },
                    css = { "prettier" },
                    scss = { "prettier" },
                    html = { "prettier" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    typescriptreact = { "prettier" },
                    svelte = { "prettier" },
                    ocaml = { "ocamlformat" },
                    php = { "easy-coding-standard" },
                    astro = { "prettier" },
                },
                format_on_save = function(bufnr)
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end
                    return { timeout_ms = 500, lsp_fallback = true, format_after_save = true }
                end,
                notify_on_error = false,
            })

            local toggle_autoformat = function() vim.g.disable_autoformat = not vim.g.disable_autoformat end
            vim.api.nvim_create_user_command("FormatToggle", toggle_autoformat, { desc = "Toggle autoformat-on-save" })
        end,
    },
}
