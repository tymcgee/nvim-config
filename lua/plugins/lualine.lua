return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "echasnovski/mini.nvim", -- for icons
        "otavioschwanck/arrow.nvim",
    },
    opts = function()
        -- not sure why this has to be in a local function but whatever
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
                lualine_x = { "" },
            },
        }
    end,
    -- config = true,
}
