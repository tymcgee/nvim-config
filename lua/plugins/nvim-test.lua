return {
    "klen/nvim-test",
    keys = {
        { "<leader>ta", "<cmd>TestSuite<cr>", desc = "Run tests" },
        { "<leader>tf", "<cmd>TestFile<cr>", desc = "Run tests in file" },
    },
    opts = {
        term = "toggleterm",
        termOpts = {
            direction = "float",
        },
    },
}
