return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    keys = { { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open git" } },
    -- config = true,
    opts = {
        -- this doesn't seem to work. maybe it does something else
        disable_line_numbers = false,
        mappings = {
            status = {
                -- so that i can use relative line jumps
                -- (doesn't work anymore :( )
                -- ["1"] = false,
                -- ["2"] = false,
                -- ["3"] = false,
                -- ["4"] = false,
            },
        },
    },
}
