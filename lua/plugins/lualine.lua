return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        "echasnovski/mini.nvim", -- for icons
        "otavioschwanck/arrow.nvim",
    },
    opts = function()
        -- could inline it by putting the statement in a string
        local function arrow()
            return require("arrow.statusline").text_for_statusline_with_icons()
        end
        return {
            options = {
                section_separators = "",
                component_separators = "",
            },
            sections = {
                lualine_c = { arrow, "filetype", "filename" },
                lualine_x = { "searchcount", "selectioncount" },
            },
        }
    end,
}
