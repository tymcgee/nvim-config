return {
    "sindrets/diffview.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open Git Diff" },
        { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close Git Diff" },
    },
    config = true,
}
