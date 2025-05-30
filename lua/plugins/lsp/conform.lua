return {
    {
        -- for a list of formatters:
        -- :help conform-formatters
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
                },
                format_on_save = function(bufnr)
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end
                    return { timeout_ms = 500, lsp_fallback = true, format_after_save = true }
                end,
                notify_on_error = false,
                formatters = {
                    prettier = {
                        prepend_args = { "--tab-width", "4" },
                    },
                },
            })

            vim.api.nvim_create_user_command("FormatToggle", function(args)
                if args.bang then
                    -- FormatToggle! will toggle just for this buffer
                    vim.b.disable_autoformat = not vim.b.disable_autoformat
                else
                    vim.g.disable_autoformat = not vim.g.disable_autoformat
                end
            end, {
                desc = "Toggle autoformat-on-save",
                bang = true,
            })

            vim.g.disable_autoformat = true
            vim.keymap.set("n", "<leader>cd", "<cmd>FormatToggle<cr>", { desc = "Toggle format on save" })
        end,
    },
    -- {
    --     "laytan/tailwind-sorter.nvim",
    --     dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    --     build = "cd formatter && npm i && npm run build",
    --     opts = {
    --         on_save_enabled = true,
    --     },
    -- },
}
