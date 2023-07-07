return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    lazy = false,
    keys = {
        { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader><leader>", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
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
                    ["q"] = function(...)
                        return require("telescope.actions").close(...)
                    end,
                },
            },
        },
    },
}
