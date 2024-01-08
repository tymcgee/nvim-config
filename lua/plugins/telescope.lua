return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        lazy = false,
        config = function()
            vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope live_grep<cr>", { desc = "Grep (root dir)" })
            vim.keymap.set("n", "<leader>:", "<cmd>Telescope command_history<cr>", { desc = "Command history" })
            vim.keymap.set("n", "<leader><space>", function()
                require("telescope.builtin").find_files({
                    find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
                })
            end, { desc = "Find files" })
            vim.keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
            vim.keymap.set("n", "<leader>sc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
            -- stylua: ignore
            vim.keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document diganostics" })
            vim.keymap.set("n", "<leader>sD", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace diagnostics" })
            vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Help pages" })
            vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
            vim.keymap.set("n", "<leader>sm", "<cmd>Telescope man_pages<cr>", { desc = "Man pages" })
            vim.keymap.set("n", "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Vim options" })

            -- lsp stuff
            -- stylua: ignore start
            vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions theme=cursor<cr>", { desc = "Go to definition(s)" })
            vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references theme=cursor<cr>", { desc = "Go to references" })
            vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations theme=cursor<cr>", { desc = "Go to implementation(s)" })
            vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions theme=cursor<cr>", { desc = "Go to type(s)" })
            -- stylua: ignore end

            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    prompt_prefix = " ",
                    selection_caret = " ",
                    mappings = {
                        n = {
                            ["q"] = actions.close,
                        },
                        i = {
                            ["<esc>"] = actions.close,
                        },
                    },
                },
                pickers = {
                    buffers = {
                        show_all_buffers = true,
                        sort_mru = true,
                    },
                    lsp_definitions = { initial_mode = "normal" },
                    lsp_references = { initial_mode = "normal" },
                    lsp_implementations = { initial_mode = "normal" },
                    lsp_type_definitions = { initial_mode = "normal" },
                },
            })
        end,
    },
}
