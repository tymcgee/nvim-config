local gh = Config.gh
vim.pack.add({ gh("stevearc/conform.nvim") })
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
    notify_on_error = true,
})

local toggle_autoformat = function() vim.g.disable_autoformat = not vim.g.disable_autoformat end
vim.api.nvim_create_user_command("FormatToggle", toggle_autoformat, { desc = "Toggle autoformat-on-save" })
vim.keymap.set("n", "<Leader>cd", "<Cmd>FormatToggle<CR>", { desc = "Toggle format on save" })
