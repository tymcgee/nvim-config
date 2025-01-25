return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "williamboman/mason.nvim",
            build = function()
                pcall(vim.cmd, "MasonUpdate")
            end,
            keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        },
        { "williamboman/mason-lspconfig.nvim" },

        { "stevearc/conform.nvim" },
        { "ibhagwan/fzf-lua" },
        { "saecki/live-rename.nvim", keys = { "<leader>cr" } },
        { "folke/lazydev.nvim", ft = "lua", opts = {} },
    },

    config = function()
        -- LSP KEYBINDINGS
        local lspconfig = require("lspconfig")
        local lsp_defaults = lspconfig.util.default_config

        -- globals
        vim.keymap.set("n", "<leader>clr", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
        vim.keymap.set("n", "<leader>cli", "<cmd>LspInfo<cr>", { desc = "LSP Info" })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to prev diagnostic" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostic float" })

        -- stylua: ignore
        lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP Actions",
            callback = function(event)
                -- stylua: ignore start
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = event.buf })
                vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "Signature help", buffer = event.buf })
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = event.buf })
                vim.keymap.set({"n", "x"}, "<leader>cf", function()
                    require("conform").format({async = true, lsp_fallback = true})
                end, {desc = "Format document", buffer = event.buf})

                vim.keymap.set("n", "<leader>cr", require("live-rename").map({text = "", insert = true}), { desc = "Rename", buffer = event.buf })
                -- stylua: ignore end
            end,
        })

        -- SERVER AND TOOL INSTALLATION
        local install_tool = function(tool)
            local mr = require("mason-registry")
            local p = mr.get_package(tool)
            if not p:is_installed() then
                p:install()
            end
        end

        -- NOTE: these are lspconfig names, not mason names
        local servers = {
            "lua_ls",
            -- "rust_analyzer",
            "gopls",
            "basedpyright",
            "bashls",
            "html",
            "jsonls",
            "svelte",
            -- "ts_ls",
            "vtsls",
            "cssls",
            "tailwindcss",
            "emmet_language_server",
            "templ",
        }

        local tools = {
            "black",
            "fixjson",
            "gofumpt",
            "prettier",
            "shfmt",
            "stylua",
            "yamlfix",
            "golangci-lint",
        }

        require("mason").setup({})
        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            ensure_installed = servers,
        })

        local installed_servers = mason_lspconfig.get_installed_servers()
        for _, server in ipairs(installed_servers) do
            lspconfig[server].setup({})
        end

        for _, tool in ipairs(tools) do
            install_tool(tool)
        end

        -- LSP CONFIG
        lspconfig.gopls.setup({ settings = { gopls = { gofumpt = true } } })

        lspconfig.html.setup({
            filetypes = { "html", "templ" },
            settings = {
                html = {
                    format = {
                        enable = false,
                    },
                },
            },
        })

        lspconfig.svelte.setup({
            settings = {
                svelte = {
                    plugin = {
                        svelte = {
                            format = {
                                config = {
                                    printWidth = 120,
                                    svelteSortOrder = "options-scripts-styles-markup",
                                },
                            },
                        },
                    },
                    enable_ts_plugin = true,
                },
            },
        })

        lspconfig.tailwindcss.setup({
            -- defaults include a lot more, but it doesn't seem like this overrides the defaults
            filetypes = { "templ" },
            init_options = {
                userLanguages = {
                    templ = "html",
                },
            },
        })

        lspconfig.emmet_language_server.setup({ filetypes = { "templ" } })

        lspconfig.basedpyright.setup({
            settings = {
                basedpyright = {
                    typeCheckingMode = "standard",
                },
            },
        })
    end,
}
