return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
        opts = {},
    },
}
