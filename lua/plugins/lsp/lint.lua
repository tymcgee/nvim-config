return {
    "mfussenegger/nvim-lint",
    config = function()
        require("lint").linters_by_ft = {
            go = { "golangcilint" },
        }

        vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost", "VimEnter", "BufEnter" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
