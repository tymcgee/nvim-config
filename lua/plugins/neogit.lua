return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
    },
    keys = { { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open git" } },
    opts = {
        graph_style = "kitty",
        disable_line_numbers = false,
        disable_relative_line_numbers = false,
        mappings = {
            status = {
                -- so that i can use relative line jumps
                ["1"] = false,
                ["2"] = false,
                ["3"] = false,
                ["4"] = false,
            },
        },
    },
}
