return {
    "stevearc/dressing.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    opts = function()
        local themes = require("telescope.themes")
        return {
            input = {
                insert_only = false,
            },
            select = {
                telescope = themes.get_dropdown({ initial_mode = "normal" }),
                -- override for the code action selection window
                get_config = function(opts)
                    if opts.kind == "codeaction" then
                        return {
                            telescope = themes.get_cursor({ initial_mode = "normal" }),
                        }
                    end
                end,
            },
        }
    end,
}
