local html_filetypes = { "html", "templ", "svelte", "tsx", "jsx", "vue", "typescriptreact" }
return {
    { "Vimjas/vim-python-pep8-indent", ft = { "python" } },
    { "windwp/nvim-autopairs", config = true, event = "VeryLazy" },
    { "catgoose/templ-goto-definition", config = true, ft = { "go" } },
    { "windwp/nvim-ts-autotag", ft = html_filetypes, opts = { opts = { enable_close_on_slash = true } } },
    { "nmac427/guess-indent.nvim", config = true, event = "BufReadPost" },
}
