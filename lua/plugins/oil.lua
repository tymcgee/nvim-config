return {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
        { "<leader>e", "<cmd>Oil<cr>", desc = "Open file directory" },
        { "<leader>E", "<cmd>Oil .<cr>", desc = "Open CWD" },
    },

    config = function()
        require("oil").setup({
            default_file_explorer = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, bufnr)
                    return name == ".git"
                end,
            },
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "oil" },
            callback = function(event)
                vim.keymap.set("n", "q", require("mini.bufremove").delete, { buffer = event.buf })
            end,
        })
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
