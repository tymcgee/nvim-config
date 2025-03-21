return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
        {
            "williamboman/mason.nvim",
            build = function()
                pcall(vim.cmd, "MasonUpdate")
            end,
            keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        },
        { "williamboman/mason-lspconfig.nvim" },
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
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to prev diagnostic" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostic float" })

        -- stylua: ignore

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

        -- SERVER AND TOOL INSTALLATION AND SETUP
        -- (this section mostly taken from kickstart)

        -- NOTE: these are lspconfig names, not mason names
        local servers = {
            bashls = {},
            jsonls = {},
            vtsls = {},
            cssls = {},
            gopls = {
                settings = { gopls = { gofumpt = true } },
            },

            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        -- ignore Lua_LS's noisy `missing-fields` warnings
                        diagnostics = { disable = { "missing-fields" } },
                    },
                },
            },

            html = {
                filetypes = { "html", "templ", "htmldjango" },
                settings = {
                    html = {
                        format = {
                            enable = false,
                        },
                    },
                },
            },

            svelte = {
                settings = {
                    svelte = {
                        enable_ts_plugin = true,
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
                    },
                },
            },

            tailwindcss = {
                filetypes = { "templ" },
                init_options = {
                    userLanguages = {
                        templ = "html",
                    },
                },
            },

            emmet_language_server = { filetypes = { "templ", "htmldjango" } },

            basedpyright = {
                settings = {
                    basedpyright = {
                        typeCheckingMode = "standard",
                    },
                },
            },
        }

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "stylua",
            "black",
            "fixjson",
            "gofumpt",
            "prettier",
            "shfmt",
            "yamlfix",
            "golangci-lint",
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {}, -- explicitly set to an empty table (it populates installs via mason-tool-installer)
            automatic_installation = false,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}
