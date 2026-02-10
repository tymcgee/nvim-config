return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
        input = { enabled = true },
        statuscolumn = { enabled = true },
        scroll = { enabled = true },
        bigfile = { enabled = true },
        picker = { enabled = true },
        image = { enabled = true },
        notifier = { enabled = true },
        rename = { enabled = true }, -- this is for renaming files
    },
    keys = {
        -- stylua: ignore start
        { "<leader><leader>", function() Snacks.picker.grep() end, desc = "Live Grep" },
        { "<leader><space>", function() Snacks.picker.smart({filter = {cwd = true}}) end, desc = "Smart Files" },
        { "<leader>sb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Vim Help Pages" },
        { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
        { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumplist" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Workspace Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics() end, desc = "Document Diagnostics" },
        { "<leader>sc", function() Snacks.picker.git_log() end, desc = "Commits" },
        { "<leader>sM", function() Snacks.picker.man() end, desc = "Man pages" },
        { "<leader>u", function() Snacks.picker.undo({layout = {preset = "right"}}) end, desc = "Undo tree" },

        -- lsp
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "gr", function() Snacks.picker.lsp_references() end, desc = "References" },
        { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
        -- stylua: ignore end
    },
}
