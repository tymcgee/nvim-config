return {
    "rest-nvim/rest.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- latest commit breaks formatting
    commit = "8b62563",
    keys = {
        {
            "<leader>rh",
            function()
                require("rest-nvim").run()
            end,
            desc = "Run HTTP request",
        },
    },
    ft = { "http" },
    config = true,
}
