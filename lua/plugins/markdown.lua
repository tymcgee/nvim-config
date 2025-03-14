return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
        opts = {},
    },
    {
        "tadmccorkle/markdown.nvim",
        ft = "markdown",
        opts = {},
        keys = {
            { "<leader>d", ":MDTaskToggle<cr>", desc = "Task (d)one" },
        },
    },
}
