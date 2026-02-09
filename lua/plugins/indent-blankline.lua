return {
    -- note: snacks also has an indent plugin, but i couldn't configure it very well. this one is very out-of-the-box, and fast
    {
        "saghen/blink.indent",
        config = function()
            -- stole this "background"-ish color from indent-blankline.nvim's default config... idk man
            vim.api.nvim_set_hl(0, "BlinkIndent", { fg = "#31353f" })
        end,
    },
}
