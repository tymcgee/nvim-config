return {
    "stevearc/oil.nvim",
    keys = {
        { "<leader>e", "<cmd>Oil<cr>", desc = "Open file directory" },
        { "<leader>E", "<cmd>Oil .<cr>", desc = "Open CWD" },
    },
    opts = {
        skip_confirm_for_simple_edits = true,
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, bufnr)
                return name == ".git"
            end,
        },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
