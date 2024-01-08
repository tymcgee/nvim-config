return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        vim.keymap.set("n", "<leader>ft", "<cmd>ToggleTerm direction=float<cr>")
        require("toggleterm").setup({
            -- (because my vim.o.shell is set to bash for other reasons)
            shell = "/bin/fish",
        })
    end,
}
