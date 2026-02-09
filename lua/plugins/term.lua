return {
    "akinsho/toggleterm.nvim",
    enabled = false,
    version = "*",
    opts = function()
        local shell = vim.fn.exepath("bash")
        if vim.fn.executable("fish") == 1 then
            shell = vim.fn.exepath("fish")
        elseif vim.fn.executable("zsh") == 1 then
            shell = vim.fn.exepath("zsh")
        end
        return {
            -- (because my vim.o.shell is set to bash for other reasons)
            shell = shell,
            float_opts = {
                border = "curved",
            },
        }
    end,
    keys = {
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Floating terminal" },
        { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Terminal" },
    },
}
