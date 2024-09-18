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
                -- { "<leader>t", group = "test" },
                { "<leader>b", group = "buffer" },
                -- doesn't work..
                { "s", group = "surround" },
                { "g", group = "goto" },
            },
        })
    end,
}
