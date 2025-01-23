return {
    "folke/snacks.nvim",
    lazy = false,
    ---@type snacks.Config
    opts = {
        input = { enabled = true },
        statuscolumn = { enabled = true },
        scroll = { enabled = true },
        bigfile = { enabled = true },
        picker = { enabled = true },
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
    keys = {
        -- stylua: ignore start
        { "<leader><leader>", function() Snacks.picker.grep() end, desc = "Live Grep" },
        { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Files" },
        { "<leader>sb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Vim Help Pages" },
        { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
        { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumplist" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Workspace Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics() end, desc = "Document Diagnostics" },
        { "<leader>sc", function() Snacks.picker.git_log() end, desc = "Commits" },
        { "<leader>sM", function() Snacks.picker.man() end, desc = "Man pages" },

        -- lsp
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "gr", function() Snacks.picker.lsp_references() end, desc = "References" },
        { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
        -- stylua: ignore end
    },
}
