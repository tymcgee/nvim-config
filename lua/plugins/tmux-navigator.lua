return {
    "christoomey/vim-tmux-navigator",
    config = function()
        vim.keymap.set({ "n", "t" }, "<c-h>", "<cmd>TmuxNavigateLeft<cr>")
        vim.keymap.set({ "n", "t" }, "<c-j>", "<cmd>TmuxNavigateDown<cr>")
        vim.keymap.set({ "n", "t" }, "<c-k>", "<cmd>TmuxNavigateUp<cr>")
        vim.keymap.set({ "n", "t" }, "<c-l>", "<cmd>TmuxNavigateRight<cr>")
    end,
}
