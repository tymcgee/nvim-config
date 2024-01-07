return {
    {
        "echasnovski/mini.ai",
        config = true,
    },
    {
        "echasnovski/mini.comment",
        config = function()
            require("mini.comment").setup({
                options = {
                    custom_commentstring = function()
                        return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
                    end,
                },
            })
        end,
    },
    {
        "echasnovski/mini.cursorword",
        config = true,
    },
    {
        "echasnovski/mini.move",
        config = true,
    },
    {
        "echasnovski/mini.bufremove",
        keys = {
            {
                "<s-q>",
                function()
                    require("mini.bufremove").delete()
                end,
                desc = "Delete Buffer",
            },
            {
                "<leader>bD",
                function()
                    require("mini.bufremove").delete(0, true)
                end,
                desc = "Force Delete Buffer",
            },
        },
        config = true,
    },
    {
        "echasnovski/mini.surround",
        opts = {
            mappings = {
                add = "gza", -- Add surrounding in Normal and Visual modes
                delete = "gzd", -- Delete surrounding
                find = "gzf", -- Find surrounding (to the right)
                find_left = "gzF", -- Find surrounding (to the left)
                highlight = "gzh", -- Highlight surrounding
                replace = "gzr", -- Replace surrounding
                update_n_lines = "gzn", -- Update `n_lines`
            },
            n_lines = 300,
        },
    },
}
