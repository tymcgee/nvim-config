return {
    { "Vimjas/vim-python-pep8-indent", ft = { "python" } },
    { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
    { "windwp/nvim-ts-autotag", ft = require("html-filetypes"), opts = { opts = { enable_close_on_slash = true } } },
    { "nmac427/guess-indent.nvim", config = true, event = "BufReadPost" },
    { "dmmulroy/ts-error-translator.nvim", ft = { "typescript" }, config = true },
}
