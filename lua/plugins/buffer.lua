return {
    "otavioschwanck/arrow.nvim",
    event = "VeryLazy",
    config = function()
        require("arrow").setup({
            show_icons = true,
            leader_key = ";", -- Recommended to be a single key
            buffer_leader_key = "m", -- Per Buffer Mappings
        })

        vim.keymap.set("n", "H", require("arrow.persist").previous)
        vim.keymap.set("n", "L", require("arrow.persist").next)
    end,
}
