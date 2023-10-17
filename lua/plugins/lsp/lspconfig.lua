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

        -- Other tools
        { "nvimdev/lspsaga.nvim",             config = true },
    },

    config = function()
        local map = function(modes, bind, action, desc, buf)
            local opts = { buffer = buf, desc = desc }
            vim.keymap.set(modes, bind, action, opts)
        end

        -- LSP KEYBINDINGS
        local lspconfig = require("lspconfig")
        local lsp_defaults = lspconfig.util.default_config

        -- globals
        vim.keymap.set("n", "<leader>cL", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
        vim.keymap.set("n", "<leader>ft", "<cmd>Lspsaga term_toggle<cr>", { desc = "Toggle a terminal popup" })
        vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Go to prev diagnostic" })
        vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Go to next diagnostic" })

        lsp_defaults.capabilities =
            vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP Actions",
            callback = function(event)
                local buf = event.buf
                map("n", "K", "<cmd>Lspsaga hover_doc<cr>", "Hover", buf)
                map("n", "gd", "<cmd>Lspsaga goto_definition<cr>", "Go to definition", buf)
                map("n", "gD", "<cmd>Lspsaga peek_definition<cr>", "Peek definition", buf)
                map("n", "gr", "<cmd>Lspsaga finder ref+def+imp<cr>", "Go to references", buf)
                map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help", buf)
                map("n", "<leader>cr", "<cmd>Lspsaga rename<cr>", "Rename", buf)
                map("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", "Code actions", buf)

                map("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", "Open diagnostic float", buf)
                map({ "n", "x" }, "<leader>cf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format document", buf)
            end,
        })

        local default_setup = function(server)
            lspconfig[server].setup({})
        end

        local servers = {
            "lua_ls",
            "rust_analyzer",
            "pyright",
            "html",
            "jsonls",
            "svelte",
            "tsserver",
            "gopls",
            -- "templ",
        }

        -- LSP CONFIG
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = servers,
        })

        for _, server in ipairs(servers) do
            default_setup(server)
        end

        lspconfig.html.setup({
            settings = {
                html = {
                    format = {
                        indentInnerHtml = true,
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

        -- lspconfig.templ.setup({ filetypes = { "html", "gohtml" } })
    end,
}
