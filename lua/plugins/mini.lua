return {
    {
        "nvim-mini/mini.nvim",
        version = false,
        config = function()
            -- setup
            require("mini.ai").setup()
            require("mini.pairs").setup()
            require("mini.cursorword").setup()
            require("mini.statusline").setup()
            require("mini.move").setup()
            require("mini.bufremove").setup()
            require("mini.icons").setup({ extension = { templ = { glyph = "", hl = "MiniIconsYellow" } } })
            MiniIcons.mock_nvim_web_devicons()

            -- stylua: ignore start
            vim.keymap.set("n", "<s-q>", MiniBufremove.delete, { desc = "Delete buffer" })
            vim.keymap.set("n", "<leader>bD", function() MiniBufremove.delete(0, true) end, { desc = "Force delete buffer" })
            -- stylua: ignore end

            -- removed mini.diff in favor of gitsigns (it has more features and integrations with other plugins, like the scrollbar)

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
