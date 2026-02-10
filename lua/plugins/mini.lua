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
            -- require("mini.notify").setup()
            require("mini.icons").setup({ extension = { templ = { glyph = "", hl = "MiniIconsYellow" } } })
            MiniIcons.mock_nvim_web_devicons()

            -- stylua: ignore start
            vim.keymap.set("n", "<s-q>", MiniBufremove.delete, { desc = "Delete buffer" })
            vim.keymap.set("n", "<leader>bD", function() MiniBufremove.delete(0, true) end, { desc = "Force delete buffer" })
            -- stylua: ignore end

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

            local clue = require("mini.clue")
            clue.setup({
                triggers = {
                    -- Leader triggers
                    { mode = { "n", "x" }, keys = "<Leader>" },
                    -- `[` and `]` keys
                    { mode = "n", keys = "[" },
                    { mode = "n", keys = "]" },
                    -- `g` key
                    { mode = { "n", "x" }, keys = "g" },
                    -- Marks
                    { mode = { "n", "x" }, keys = "'" },
                    { mode = { "n", "x" }, keys = "`" },
                    -- Registers
                    { mode = { "n", "x" }, keys = '"' },
                    { mode = { "i", "c" }, keys = "<C-r" },
                    -- `z` key
                    { mode = { "n", "x" }, keys = "z" },
                },
                clues = {
                    clue.gen_clues.square_brackets(),
                    clue.gen_clues.builtin_completion(),
                    clue.gen_clues.g(),
                    clue.gen_clues.marks(),
                    clue.gen_clues.registers(),
                    clue.gen_clues.z(),
                    { mode = "n", keys = "<Leader>b", desc = "+Buffers" },
                    { mode = "n", keys = "<Leader>c", desc = "+Code" },
                    { mode = "n", keys = "<Leader>cl", desc = "+LSP" },
                    { mode = "n", keys = "<Leader>g", desc = "+Git" },
                    { mode = "n", keys = "<Leader>s", desc = "+Search" },
                    { mode = "n", keys = "<Leader>q", desc = "+Session" },
                },
                window = { delay = 300 },
            })
        end,
    },
}
