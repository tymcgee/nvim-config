return {
    { "Vimjas/vim-python-pep8-indent", ft = { "python" } },
    { "windwp/nvim-autopairs", config = true, event = "VeryLazy" },
    { "catgoose/templ-goto-definition", config = true, ft = { "go" } },
    { "windwp/nvim-ts-autotag", ft = require("html-filetypes"), opts = { opts = { enable_close_on_slash = true } } },
    { "nmac427/guess-indent.nvim", config = true, event = "BufReadPost" },
    { "mbbill/undotree", keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo tree" } } },
}
