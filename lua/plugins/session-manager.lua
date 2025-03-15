return {
    "Shatur/neovim-session-manager",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = false,
    keys = { { "<leader>qc", "<cmd>SessionManager load_session<cr>", desc = "Choose session" } },
    opts = function()
        local config = require("session_manager.config")
        return {
            autoload_mode = config.AutoloadMode.Disabled,
        }
    end,
}
