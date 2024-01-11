return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        vim.keymap.set("n", "<leader>ft", "<cmd>ToggleTerm direction=float<cr>")
        vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>")
        local shell = "/bin/bash"
        if vim.fn.executable("fish") == 1 then
            shell = "/bin/fish"
        elseif vim.fn.executable("zsh") == 1 then
            shell = "/bin/zsh"
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
