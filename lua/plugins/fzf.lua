return {
    "ibhagwan/fzf-lua",
    enabled = false,
    dependencies = {
        {
            "MeanderingProgrammer/render-markdown.nvim",
            dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
            ---@module 'render-markdown'
            ---@type render.md.UserConfig
            opts = {},
        },
    },
    cmd = "FzfLua",
    config = function()
        local fzf = require("fzf-lua")
        local config = fzf.config
        local actions = fzf.actions
        config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
        config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"

        fzf.setup({
            {
                files = {
                    cwd_prompt = false,
                    actions = {
                        ["alt-i"] = { actions.toggle_ignore },
                        ["alt-h"] = { actions.toggle_hidden },
                    },
                },
                grep = {
                    actions = {
                        ["alt-i"] = { actions.toggle_ignore },
                        ["alt-h"] = { actions.toggle_hidden },
                    },
                },
            },
        })
        fzf.register_ui_select()
    end,
    keys = {
        -- move up and down
        { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
        { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
        -- keymaps
        { "<leader><leader>", "<cmd>FzfLua live_grep_resume<cr>", desc = "Live grep" },
        { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Files" },
        { "<leader>sb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "Help" },
        { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
        { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
        { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
        { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
        { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
        { "<leader>sc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
        { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
    },
    -- TODO: c-u to delete the existing text on resume? or another keymap to delete the current search
}
