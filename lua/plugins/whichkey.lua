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
                { "<leader>f", group = "files" },
                { "<leader>g", group = "git" },
                { "<leader>q", group = "quit" },
                { "<leader>r", group = "run" },
                { "<leader>s", group = "search" },
                { "<leader>b", group = "buffer" },
                { "s", group = "substitute" },
                { "g", group = "goto" },
            },
        })
    end,
}
