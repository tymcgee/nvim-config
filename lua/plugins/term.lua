return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        vim.keymap.set("n", "<leader>ft", "<cmd>ToggleTerm direction=float<cr>")
        vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>")
        local shell = vim.fn.exepath("bash")
        if vim.fn.executable("fish") == 1 then
            shell = vim.fn.exepath("fish")
        elseif vim.fn.executable("zsh") == 1 then
            shell = vim.fn.exepath("zsh")
        end
        require("toggleterm").setup({
            -- (because my vim.o.shell is set to bash for other reasons)
            shell = shell,
            float_opts = {
                border = "curved",
            },
        })
    end,
}
