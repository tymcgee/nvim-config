return {
    "L3MON4D3/LuaSnip",
    lazy = true,
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load()
        require("luasnip").setup({
            region_check_events = "InsertEnter",
            delete_check_events = "InsertLeave",
        })

        -- when switching back to normal mode, remove all active snippet jump locations
        -- from https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
        vim.api.nvim_create_autocmd("ModeChanged", {
            pattern = "*",
            callback = function()
                if
                    ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
                    and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                    and not require("luasnip").session.jump_active
                then
                    require("luasnip").unlink_current()
                end
            end,
        })
    end,
    keys = {
        {
            "<tab>",
            function()
                return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
            end,
            expr = true,
            silent = true,
            mode = "i",
        },
        {
            "<tab>",
            function()
                require("luasnip").jump(1)
            end,
            mode = "s",
        },
        {
            "<s-tab>",
            function()
                require("luasnip").jump(-1)
            end,
            mode = { "i", "s" },
        },
    },
}
