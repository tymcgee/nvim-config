return {
    "nvimdev/dashboard-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
                        action = "cd ~/.config/nvim | e init.lua | SessionManager load_current_dir_session",
                        desc = " Config",
                        icon = " ",
                        key = "c",
                    },
                    {
                        action = "SessionManager load_current_dir_session",
                        desc = " Load Session",
                        icon = "󰮲 ",
                        key = "l",
                    },
                    {
                        action = "SessionManager load_last_session",
                        desc = " Restore Previous Session",
                        icon = " ",
                        key = "s",
                    },
                    {
                        action = "SessionManager load_session",
                        desc = " Choose Session",
                        icon = "󰕲 ",
                        key = "o",
                    },
                    { action = "qa", desc = " Quit", icon = " ", key = "q" },
                },
                footer = {},
            },
        }

        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "DashboardLoaded",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        return opts
    end,
}
