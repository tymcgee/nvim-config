return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufWritePost", "BufNewFile" },
    dependencies = {
        { "mason-org/mason.nvim", keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } } },
        { "mason-org/mason-lspconfig.nvim" },
        { "WhoIsSethDaniel/mason-tool-installer.nvim" },

        { "j-hui/fidget.nvim", opts = {} },
        { "stevearc/conform.nvim" },
        { "saecki/live-rename.nvim", keys = { "<leader>cr" } },
        { "folke/lazydev.nvim", ft = "lua", opts = {} },
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

        -- add the same capabilities to all server configurations
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        local is_installed = function(cmd)
            return function()
                return not vim.fn.executable(cmd)
            end
        end

        require("mason").setup()
        require("mason-lspconfig").setup()
        require("mason-tool-installer").setup({
            auto_update = true,
            -- stylua: ignore start
            ensure_installed = {
                -- language servers
                "bashls",
                "jsonls",
                "cssls",
                "taplo",
                "yamlls",
                "vtsls",
                { "gopls", condition = is_installed("go") },
                { "templ", condition = is_installed("go") },
                "lua_ls",
                "html",
                "svelte",
                "tailwindcss",
                "emmet_language_server",
                "basedpyright",
                "docker_compose_language_service",
                "dockerls",
                { "terraformls", condition = is_installed("terraform") },
                -- tools
                "stylua",
                "fixjson",
                "shfmt",
                "yamlfmt",
                "ruff",
                { "gofumpt", condition = is_installed("go") },
                { "golangci-lint", condition = is_installed("go") },
                "prettier",
            },
            -- stylua: ignore end
        })
    end,
}
