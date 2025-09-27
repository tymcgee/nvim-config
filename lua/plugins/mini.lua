return {
    {
        "nvim-mini/mini.nvim",
        version = false,
        config = function()
            -- setup
            require("mini.ai").setup()
            require("mini.cursorword").setup()
            require("mini.move").setup()
            require("mini.bufremove").setup()
            require("mini.icons").setup({ extension = { templ = { glyph = "", hl = "MiniIconsYellow" } } })
            MiniIcons.mock_nvim_web_devicons()

            -- stylua: ignore start
            vim.keymap.set("n", "<s-q>", MiniBufremove.delete, { desc = "Delete buffer" })
            vim.keymap.set("n", "<leader>bD", function() MiniBufremove.delete(0, true) end, { desc = "Force delete buffer" })
            -- stylua: ignore end

            require("mini.diff").setup({
                view = {
                    style = "sign",
                    signs = { add = "▌", change = "▌", delete = "▁" },
                },
                delay = { text_change = 50 },
            })
            vim.keymap.set("n", "<leader>gh", MiniDiff.toggle_overlay, { desc = "Toggle git hunk overlay" })

            require("mini.surround").setup({
                mappings = {
                    add = "ys", -- Add surrounding in Normal and Visual modes
                    delete = "ds", -- Delete surrounding
                    replace = "cs", -- Change (replace) surrounding
                    -- disabled, I don't use them
                    find = "",
                    find_left = "",
                    highlight = "",
                    update_n_lines = "",
                },
            })
        end,
    },
}
