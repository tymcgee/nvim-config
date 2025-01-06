return {
    "christoomey/vim-tmux-navigator",
    keys = {
        { mode = { "n", "t" }, "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
        { mode = { "n", "t" }, "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
        { mode = { "n", "t" }, "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
        { mode = { "n", "t" }, "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
}
