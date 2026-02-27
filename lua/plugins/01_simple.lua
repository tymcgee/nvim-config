return {
    { "navarasu/onedark.nvim", priority = 1000, config = function() require("onedark").load() end },
    { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
    { "windwp/nvim-ts-autotag", ft = require("html-filetypes"), opts = { opts = { enable_close_on_slash = true } } },
    { "nmac427/guess-indent.nvim", config = true, event = "BufReadPost" },
    { "dmmulroy/ts-error-translator.nvim", ft = { "typescript" }, config = true },
    { "lewis6991/gitsigns.nvim", event = { "BufReadPost" }, config = true },
    { "MagicDuck/grug-far.nvim", cmd = "GrugFar", config = true },
    { "rmagatti/auto-session", lazy = false, config = true },
    -- stole this "background"-ish color from indent-blankline.nvim's default config... idk man
    { "saghen/blink.indent", config = function() vim.api.nvim_set_hl(0, "BlinkIndent", { fg = "#31353f" }) end },
    -- :help diff-mode for some more info on how this works natively
    { "sindrets/diffview.nvim", opts = { file_panel = { listing_style = "list" } } },
    { "saecki/live-rename.nvim" },
    { "MeanderingProgrammer/render-markdown.nvim", ft = "markdown", opts = { completions = { lsp = { enabled = true } } } },

    -- terminal navigator
    {
        "MunsMan/kitty-navigator.nvim",
        build = {
            "cp navigate_kitty.py ~/.config/kitty",
            "cp pass_keys.py ~/.config/kitty",
        },
    },

    -- lsp
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },

    -- snacks
    {
        "folke/snacks.nvim",
        opts = {
            input = { enabled = true },
            picker = { enabled = true },
            image = { enabled = true },
        },
    }
}
