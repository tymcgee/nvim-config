return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            diagnostics = "nvim_lsp",
            separator_style = "slant",
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)
        vim.keymap.set("n", "<s-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
        vim.keymap.set("n", "<s-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
        vim.keymap.set("n", "<A-v>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer to the right" })
        vim.keymap.set("n", "<A-c>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer to the left" })
    end,
}
