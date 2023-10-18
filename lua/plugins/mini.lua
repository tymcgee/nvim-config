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
                        return require("ts_context_commentstring.internal").calculate_commentstring()
                            or vim.bo.commentstring
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
    {
        "echasnovski/mini.files",
        lazy = false,
        keys = {
            {
                "<leader>e",
                function()
                    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
                end,
                desc = "Open mini.files (directory of current file)",
            },
            {
                "<leader>E",
                function()
                    require("mini.files").open(vim.loop.cwd(), true)
                end,
                desc = "Open mini.files (cwd)",
            },
        },
        opts = {
            options = {
                use_as_default_explorer = true,
            },
        },
    },
    {
        "echasnovski/mini.sessions",
        lazy = false,
        keys = {
            { "<leader>qs", "<cmd>lua MiniSessions.read()<cr>",       desc = "Restore session" },
            { "<leader>ql", "<cmd>lua MiniSessions.get_latest()<cr>", desc = "Restore latest session" },
            { "<leader>qw", ":lua MiniSessions.write(",               desc = "Create new session" },
        },
        config = true,
    },
}
