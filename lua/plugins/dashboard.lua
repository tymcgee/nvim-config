return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
        local logo = vim.fn.system({ "cat", vim.fn.stdpath("config") .. "/logo.txt" })
        logo = vim.split(logo, "\n")
        local opts = {
            theme = "doom",
            -- can use this instead of header if you want to lolcat the logo
            -- preview = {
            --     command = "cat",
            --     -- command = "lolcat",
            --     file_path = vim.fn.stdpath("config") .. "/logo.txt",
            --     file_height = 9,
            --     file_width = 54,
            -- },
            config = {
                header = logo,
                center = {
                    { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
                    { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
                    { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
                    { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
                    {
                        action = "cd ~/.config/nvim | lua MiniSessions.read()",
                        desc = " Config",
                        icon = " ",
                        key = "c",
                    },
                    {
                        action = "lua MiniSessions.read()",
                        desc = " Restore Session",
                        icon = " ",
                        key = "s",
                    },
                    { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
                    { action = "qa", desc = " Quit", icon = " ", key = "q" },
                },
                footer = {},
            },
        }
        return opts
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
