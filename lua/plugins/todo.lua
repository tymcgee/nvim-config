return {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
        -- stylua: ignore start
        { "<leader>st", function() require("todo-comments.fzf").todo() end, desc = "Todo" },
        { "<leader>sT", function () require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
        -- stylua: ignore end
    },
}
