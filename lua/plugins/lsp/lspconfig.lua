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
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = event.buf })
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition", buffer = event.buf })
                vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "Signature help", buffer = event.buf })
                vim.keymap.set({"n", "x"}, "<leader>cf", function()
                    require("conform").format({async = true, lsp_fallback = true})
                end, {desc = "Format document", buffer = event.buf})

                -- fzf pickers
                vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", { desc = "See references", buffer = event.buf })
                vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<cr>", { desc = "See implementations", buffer = event.buf })
                -- the input for this is overridden by snacks.input
                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = event.buf })
                vim.keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", { desc = "Code actions", buffer = event.buf })
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
            "rust_analyzer",
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
