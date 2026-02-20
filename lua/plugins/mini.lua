return {
    {
        "nvim-mini/mini.nvim",
        version = false,
        config = function()
            -- setup
            require("mini.ai").setup()
            require("mini.cursorword").setup()
            require("mini.statusline").setup()
            require("mini.move").setup()
            require("mini.bufremove").setup()
            require("mini.extra").setup()
            -- require("mini.notify").setup()
            require("mini.icons").setup({ extension = { templ = { glyph = "", hl = "MiniIconsYellow" } } })
            MiniIcons.mock_nvim_web_devicons()

            -- stylua: ignore start
            vim.keymap.set("n", "<s-q>", MiniBufremove.delete, { desc = "Delete buffer" })
            vim.keymap.set("n", "<leader>bD", function() MiniBufremove.delete(0, true) end, { desc = "Force delete buffer" })
            -- stylua: ignore end

            local animate = require("mini.animate")
            animate.setup({
                cursor = { enable = false },
                scroll = { timing = animate.gen_timing.linear({ duration = 150, unit = "total" }) },
            })

            require("mini.operators").setup({
                replace = { prefix = "s" },
                exchange = { prefix = "" }, -- don't override gx (open link)
                sort = { prefix = "" }, -- don't override gs (signature help)
            })

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

            local hipatterns = require("mini.hipatterns")
            local hi_words = MiniExtra.gen_highlighter.words
            hipatterns.setup({
                highlighters = {
                    fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
                    todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
                    note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

                    -- Highlight hex color string (#aabbcc) with that color as a background
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })
        end,
    },
}
