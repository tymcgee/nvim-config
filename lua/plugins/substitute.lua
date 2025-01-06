return {
    "gbprod/substitute.nvim",
    config = function()
        require("substitute").setup({
            highlight_substituted_text = {
                enabled = false,
            },
        })
        vim.keymap.set("n", "s", require("substitute").operator, { noremap = true, desc = "Substitute" })
        vim.keymap.set("n", "ss", require("substitute").line, { noremap = true, desc = "Substitute line" })
        vim.keymap.set("n", "S", require("substitute").eol, { noremap = true, desc = "Substitute to end of line" })
        vim.keymap.set("x", "s", require("substitute").visual, { noremap = true, desc = "Substitute" })
    end,
    keys = {
        { "s" },
        { "ss" },
        { "S" },
        { mode = "x", "s" },
    },
}
