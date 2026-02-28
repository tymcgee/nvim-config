return {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            skip_confirm_for_simple_edits = true,
            cleanup_delay_ms = 300, -- default is 2000, but i want a quick ctrl+o not to go back to oil
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, bufnr) return name == ".git" or name == ".jj" end,
            },
            keymaps = {
                -- don't conflict with tmux navigator
                ["<C-l>"] = false,
                ["<C-h>"] = false,
            },
        })
    end,
}
