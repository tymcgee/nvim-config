return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        "echasnovski/mini.nvim", -- for icons
    },
    opts = function()
        return {
            options = {
                section_separators = "",
                component_separators = "",
            },
            sections = {
                lualine_c = { "filetype", "filename" },
                lualine_x = { "searchcount", "selectioncount" },
            },
        }
    end,
}
