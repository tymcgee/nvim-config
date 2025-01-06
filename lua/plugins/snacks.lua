return {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
        input = { enabled = true },
        statuscolumn = { enabled = true },
        scroll = { enabled = true },
        dashboard = {
            enabled = true,
            preset = {
                -- mostly defaults, other than using "l" instead of "s" for the "restore session" command
                keys = {
                    -- stylua: ignore start
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "l", desc = "Restore Session", section = "session" },
                    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    -- stylua: ignore end
                },
            },
        },
    },
}
