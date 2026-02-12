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
            cleanup_delay_ms = 300, -- default is 2000, but i want a quick ctrl+o not to go back to oil
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, bufnr)
                    return name == ".git" or name == ".jj"
                end,
            },
            keymaps = {
                -- don't conflict with tmux navigator
                ["<C-l>"] = false,
                ["<C-h>"] = false,
            },
        })

        -- autocommands
        local augroup = vim.api.nvim_create_augroup("myoil", { clear = true })

        -- press 'q' to close oil if it is open (doing it here instead of in autocommands.lua since this one is reliant on mini.bufremove to work properly)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "oil" },
            group = augroup,
            callback = function(event)
                vim.keymap.set("n", "q", require("mini.bufremove").delete, { buffer = event.buf })
            end,
        })

        -- if you delete a file, also delete its buffer (taken from https://github.com/stevearc/oil.nvim/issues/612#issuecomment-2828601810)
        vim.api.nvim_create_autocmd("User", {
            pattern = "OilActionsPost",
            group = augroup,
            callback = function(e)
                if e.data.actions == nil then
                    return
                end
                for _, action in ipairs(e.data.actions) do
                    if action.entry_type == "file" and action.type == "delete" then
                        local file = action.url:sub(7)
                        local bufnr = vim.fn.bufnr(file)

                        if bufnr >= 0 then
                            vim.api.nvim_buf_delete(bufnr, { force = true })
                        end
                    end
                end
            end,
        })
    end,
    -- Optional dependencies
    dependencies = { "echasnovski/mini.nvim" }, -- for icons
}
