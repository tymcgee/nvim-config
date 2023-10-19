return {
    "Shatur/neovim-session-manager",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = false,
    keys = {
        { "<leader>qs", "<cmd>SessionManager load_current_dir_session<cr>", desc = "Load session for CWD" },
        { "<leader>ql", "<cmd>SessionManager load_last_session<cr>",        desc = "Load previous session" },
        { "<leader>qc", "<cmd>SessionManager load_session<cr>",             desc = "Select session" },
    },
    opts = function()
        local config = require("session_manager.config")
        return {
            autoload_mode = config.AutoloadMode.Disabled
        }
    end
}
