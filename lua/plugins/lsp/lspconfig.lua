return {
    "neovim/nvim-lspconfig",
    -- don't lazy load lspconfig or else syntax highlighting dies
    -- event = { "BufReadPre", "BufWritePost", "BufNewFile" },
    dependencies = {
        { "mason-org/mason.nvim", opts = {}, keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } } },
        { "mason-org/mason-lspconfig.nvim" },

        { "stevearc/conform.nvim" },
        { "saecki/live-rename.nvim", keys = { "<leader>cr" } },
    },

    config = function()
        -- LSP KEYBINDINGS
        vim.keymap.set("n", "<leader>clr", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
        vim.keymap.set("n", "<leader>cli", "<cmd>LspInfo<cr>", { desc = "LSP Info" })
        -- stylua: ignore start
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count=1, float=true}) end, { desc = "Go to prev diagnostic" })
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count=-1, float=true}) end, { desc = "Go to next diagnostic" })
        -- stylua: ignore end
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP Actions",
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                local format = function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end

                local rename = function()
                    return require("live-rename").map({ text = "", insert = true })
                end

                map("K", vim.lsp.buf.hover, "Hover")
                map("gs", vim.lsp.buf.signature_help, "Signature help")
                map("<leader>ca", vim.lsp.buf.code_action, "Code actions")
                map("<leader>cf", format, "Format document")
                map("<leader>cr", rename(), "Rename symbol")
            end,
        })

        require("plugins.lsp.required")
        require("mason-lspconfig").setup()

        -- enable other servers not controlled by mason
        vim.lsp.enable("gleam")
    end,
}
