return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = {
        theme = "doom",
        config = {
            center = {
                { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
                { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
                { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
                { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
                {
                    action = "cd ~/.config/nvim | lua require('persistence').load()",
                    desc = " Config",
                    icon = " ",
                    key = "c",
                },
                { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
                { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
                { action = "qa", desc = " Quit", icon = " ", key = "q" },
            },
            footer = {},
        },
    },
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
