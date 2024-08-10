return {
    "Shatur/neovim-session-manager",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = false,
    opts = function()
        local config = require("session_manager.config")
        return {
            autoload_mode = config.AutoloadMode.Disabled,
        }
    end,
}
