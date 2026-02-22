return {
    { "navarasu/onedark.nvim", priority = 1000, config = function() require("onedark").load() end },
    { "Vimjas/vim-python-pep8-indent", ft = { "python" } },
    { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
    { "windwp/nvim-ts-autotag", ft = require("html-filetypes"), opts = { opts = { enable_close_on_slash = true } } },
    { "nmac427/guess-indent.nvim", config = true, event = "BufReadPost" },
    { "dmmulroy/ts-error-translator.nvim", ft = { "typescript" }, config = true },
    { "lewis6991/gitsigns.nvim", event = { "BufReadPost" }, config = true },
    { "MagicDuck/grug-far.nvim", cmd = "GrugFar", config = true },
    -- stole this "background"-ish color from indent-blankline.nvim's default config... idk man
    { "saghen/blink.indent", config = function() vim.api.nvim_set_hl(0, "BlinkIndent", { fg = "#31353f" }) end },
}
