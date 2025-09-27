return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost" },
    opts = {},
    config = function()
        local gs = require("gitsigns")
        vim.keymap.set("n", "<leader>gh", gs.preview_hunk_inline, { desc = "Toggle git hunk (inline)" })
        vim.keymap.set("n", "<leader>gb", gs.blame, { desc = "Toggle git hunk (inline)" })
        vim.keymap.set("n", "[h", function()
            gs.nav_hunk("prev")
        end, { desc = "Previous git hunk" })
        vim.keymap.set("n", "]h", function()
            gs.nav_hunk("next")
        end, { desc = "Next git hunk" })
        -- TODO: figure out a clean way to exit out of the diff. right now i have to move to the diffed buffer and :q it
        vim.keymap.set("n", "<leader>gd", gs.diffthis, { desc = "Diff the current file" })
    end,
}
