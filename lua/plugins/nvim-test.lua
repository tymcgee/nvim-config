return {
    "klen/nvim-test",
    keys = {
        { "<leader>rt", "<cmd>TestSuite<cr>", desc = "Run Tests" },
    },
    -- TODO: make it so that pressing q after a test closes it immediately
    -- right now, you have to enter insert mode in order to do that
    opts = {
        termOpts = {
            direction = "float",
        },
    },
}
