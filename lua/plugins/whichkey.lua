return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        plugins = { spelling = true },
        preset = "helix",
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.add({
            {
                mode = { "n", "v" },
                { "<leader>c", group = "code" },
                { "<leader>cl", group = "LSP" },
                { "<leader>g", group = "git" },
                { "<leader>r", group = "run" },
                { "<leader>s", group = "search" },
                { "<leader>b", group = "buffer" },
                { "<leader>t", group = "terminal" },
                { "s", group = "substitute" },
                { "g", group = "goto" },
            },
        })
    end,
}
