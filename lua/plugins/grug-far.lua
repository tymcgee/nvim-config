return {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
        { "<leader>sr", "<cmd>GrugFar<cr>", desc = "Search and replace" },
    },
    opts = {
        keymaps = {
            close = { n = "q" },
        },
    },
}
