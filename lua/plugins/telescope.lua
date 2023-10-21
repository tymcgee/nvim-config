return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = false,
    keys = {
        { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader><leader>", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        {
            "<leader><space>",
            function()
                require("telescope.builtin").find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } })
            end,
            desc = "Find Files (root dir)",
        },
        { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
        { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        { "<leader>sm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    },
    opts = {
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            mappings = {
                n = {
                    -- ngl I don't understand this
                    ["q"] = function(_)
                        require("telescope.actions").close(_)
                    end,
                },
            },
        },
        pickers = {
            buffers = {
                show_all_buffers = true,
                sort_mru = true,
                mappings = {
                    i = {
                        -- TODO: this doesn't work because the default s-q happens first
                        -- ["<s-q>"] = "delete_buffer",
                    },
                },
            },
        },
    },
}
