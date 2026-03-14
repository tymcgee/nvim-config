return {
    -- navigator
    {
        "MunsMan/kitty-navigator.nvim",
        build = {
            "cp navigate_kitty.py ~/.config/kitty",
            "cp pass_keys.py ~/.config/kitty",
        },
    },
    -- scrollback
    {
        "mikesmithgh/kitty-scrollback.nvim",
        enabled = true,
        lazy = true,
        cmd = {
            "KittyScrollbackGenerateKittens",
            "KittyScrollbackCheckHealth",
            "KittyScrollbackGenerateCommandLineEditing",
        },
        event = { "User KittyScrollbackLaunch" },
        version = "^6.0.0", -- pin major version, include fixes and features that do not have breaking changes
        config = function() require("kitty-scrollback").setup() end,
    },
}
