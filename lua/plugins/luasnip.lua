return {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip").setup({
            region_check_events = "InsertEnter",
            delete_check_events = "InsertLeave",
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
