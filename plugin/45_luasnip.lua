local gh = Config.gh
vim.pack.add({ { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("v2.*") } })
-- note: not installing jsregexp because i don't expect to use those features of this plugin

require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_lua").lazy_load()
require("luasnip").setup({
    region_check_events = "InsertEnter",
    delete_check_events = "InsertLeave",
    update_events = { "TextChanged", "TextChangedI" },
})

-- this is pretty scuffed, but i want to cancel snippets when switching back to normal mode.
-- this used to be doable with an autocommand (see https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436)
-- but that doesn't work with blink for some reason.
-- so this is the new workaround (from https://github.com/saghen/blink.cmp/issues/2035#issuecomment-3125752129)
-- this is scuffed because esc isn't the only way to go back to normal mode, but for my purposes it is. so it's fine
vim.keymap.set({ "i", "s" }, "<esc>", function()
    if require("luasnip").expand_or_jumpable() then
        require("luasnip").unlink_current()
    end
    return "<esc>"
end, { desc = "Cancel snippets when returning to normal mode", expr = true })
