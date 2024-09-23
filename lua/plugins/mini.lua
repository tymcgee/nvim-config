return {

    {
        "echasnovski/mini.nvim",
        version = false,
        config = function()
            -- setup
            require("mini.ai").setup()
            require("mini.cursorword").setup()
            require("mini.move").setup()
            require("mini.bufremove").setup()
            require("mini.surround").setup({
                mappings = {
                    add = "ysa", -- Add surrounding in Normal and Visual modes
                    delete = "ysd", -- Delete surrounding
                    replace = "ysc", -- Change (replace) surrounding
                    -- disabled, I don't use them
                    find = "", -- Find surrounding (to the right)
                    find_left = "", -- Find surrounding (to the left)
                    highlight = "", -- Highlight surrounding
                    update_n_lines = "", -- Update `n_lines`
                },
            })
            require("mini.comment").setup({
                options = {
                    custom_commentstring = function()
                        return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
                    end,
                },
            })

            -- keymaps
            -- stylua: ignore start
            vim.keymap.set("n", "<s-q>", MiniBufremove.delete, { desc = "Delete buffer" })
            vim.keymap.set("n", "<leader>bD", function() MiniBufremove.delete(0, true) end, { desc = "Force delete buffer" })
            -- stylua: ignore end
        end,
    },
}
