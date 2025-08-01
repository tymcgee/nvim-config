return {
    "Shatur/neovim-session-manager",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = false,
    keys = { { "<leader>qc", "<cmd>SessionManager load_session<cr>", desc = "Choose session" } },
    opts = function()
        local config = require("session_manager.config")
        local autoload_mode = config.AutoloadMode.CurrentDir
        if vim.g.neovide then
            autoload_mode = config.AutoloadMode.Disabled
            vim.schedule(function()
                vim.cmd("SessionManager load_session")
            end)
        end
        return {
            autoload_mode = autoload_mode,
        }
    end,
}
