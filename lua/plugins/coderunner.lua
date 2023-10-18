return {
    "CRAG666/code_runner.nvim",
    keys = {
        { "<leader>rc", "<cmd>RunCode<cr>", desc = "Run Code" },
        { "<leader>rp", "<cmd>RunProject<cr>", desc = "Run Project" },
    },
    opts = {
        filetype = {
            python = "python3",
            -- If you're developing in /src, then $dir/.. is the root directory
            rust = "cd $dir/.. && cargo run",
            go = "go run .",
        },
        mode = "float",
        float = {
            close_key = "q",
            border = "rounded",
        },
    },
}
