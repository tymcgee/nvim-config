return {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim", -- optional
        "neovim/nvim-lspconfig", -- optional
    },
    opts = {
        -- i start the tailwind LS on my own
        server = {
            enabled = false,
        },
        document_color = {
            enabled = false,
        },
        cmp = {
            highlight = "background",
        },
    },
}
